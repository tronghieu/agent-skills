#!/usr/bin/env node
// slidewright-remote.mjs — phone remote control for a slidewright deck.
//
// Zero dependencies (Node >= 18). Works offline, which matters at venues with no
// internet. It provides:
//   - a WebSocket relay on the local network (/__slidewright/ws)
//   - a phone remote page (/remote?t=<token>)
//   - a deck-side client script (/__slidewright/client.js), injected into HTML pages
//   - a QR code of the remote URL, printed in the terminal
//
// Two ways to run it:
//   Plain-HTML deck:  node slidewright-remote.mjs [deck-dir] [--port 8000] [--host <ip>] [--token <t>]
//                     Serves the deck folder statically and prints the QR code.
//   Vite + React:     import { slidewrightRemote } from './remote/slidewright-remote.mjs'
//                     plugins: [react(), tailwindcss(), slidewrightRemote()]
//                     `npm run dev` then prints the QR code under Vite's URLs.
//
// Deck contract: the deck exposes window.slidewright = { go(i), next(), prev(),
// getState() -> { current, total, title, next? } } and dispatches a
// 'slidewright:change' event on window whenever the slide changes. A deck without
// that API still gets next/prev through simulated ArrowRight/ArrowLeft keydowns.
//
// Security: anyone on the same network who has the remote URL can change slides.
// The URL carries a random token; the relay refuses remote connections without it.

import { createServer } from 'node:http'
import { createHash, randomBytes } from 'node:crypto'
import { networkInterfaces } from 'node:os'
import { readFile, stat } from 'node:fs/promises'
import { extname, join, normalize, resolve, sep, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const BASE = '/__slidewright'
const WS_GUID = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'

// ---------------------------------------------------------------------------
// QR code encoder — byte mode, error-correction level M, versions 1–10
// (up to 213 bytes, far more than a LAN URL needs). Follows ISO/IEC 18004.
// ---------------------------------------------------------------------------

// [ecCodewordsPerBlock, [[blockCount, dataCodewordsPerBlock], ...]] for level M.
const QR_M_BLOCKS = [
  null,
  [10, [[1, 16]]], [16, [[1, 28]]], [26, [[1, 44]]], [18, [[2, 32]]], [24, [[2, 43]]],
  [16, [[4, 27]]], [18, [[4, 31]]], [22, [[2, 38], [2, 39]]], [22, [[3, 36], [2, 37]]],
  [26, [[4, 43], [1, 44]]],
]
const QR_ALIGN = [null, [], [6, 18], [6, 22], [6, 26], [6, 30], [6, 34], [6, 22, 38], [6, 24, 42], [6, 26, 46], [6, 28, 50]]

function gfMul(x, y) {
  let z = 0
  for (let i = 7; i >= 0; i--) {
    z = (z << 1) ^ ((z >>> 7) * 0x11d)
    z ^= ((y >>> i) & 1) * x
  }
  return z
}

function rsDivisor(degree) {
  const result = new Array(degree).fill(0)
  result[degree - 1] = 1
  let root = 1
  for (let i = 0; i < degree; i++) {
    for (let j = 0; j < degree; j++) {
      result[j] = gfMul(result[j], root)
      if (j + 1 < degree) result[j] ^= result[j + 1]
    }
    root = gfMul(root, 0x02)
  }
  return result
}

function rsRemainder(data, divisor) {
  const result = new Array(divisor.length).fill(0)
  for (const b of data) {
    const factor = b ^ result.shift()
    result.push(0)
    divisor.forEach((coef, i) => { result[i] ^= gfMul(coef, factor) })
  }
  return result
}

/** Encode text as a QR code (`mask` forces a mask pattern, for tests). Returns a square array of rows of booleans (true = dark). */
export function encodeQR(text, { mask } = {}) {
  const bytes = [...Buffer.from(text, 'utf8')]
  let version = 0
  for (let v = 1; v <= 10; v++) {
    const [, groups] = QR_M_BLOCKS[v]
    const capacity = groups.reduce((n, [count, len]) => n + count * len, 0)
    const countBits = v < 10 ? 8 : 16
    if (4 + countBits + bytes.length * 8 <= capacity * 8) { version = v; break }
  }
  if (!version) throw new Error(`QR: text too long (${bytes.length} bytes, max 213)`)

  const [ecLen, groups] = QR_M_BLOCKS[version]
  const dataCapacity = groups.reduce((n, [count, len]) => n + count * len, 0)

  // Bit stream: mode indicator, character count, data, terminator, padding.
  const bits = []
  const push = (val, len) => { for (let i = len - 1; i >= 0; i--) bits.push((val >>> i) & 1) }
  push(0b0100, 4)
  push(bytes.length, version < 10 ? 8 : 16)
  bytes.forEach((b) => push(b, 8))
  push(0, Math.min(4, dataCapacity * 8 - bits.length))
  push(0, (8 - (bits.length % 8)) % 8)
  const data = []
  for (let i = 0; i < bits.length; i += 8) data.push(parseInt(bits.slice(i, i + 8).join(''), 2))
  for (let pad = 0xec; data.length < dataCapacity; pad ^= 0xec ^ 0x11) data.push(pad)

  // Split into blocks, add error correction, interleave.
  const divisor = rsDivisor(ecLen)
  const blocks = []
  let offset = 0
  for (const [count, len] of groups) {
    for (let i = 0; i < count; i++) {
      const d = data.slice(offset, offset + len)
      offset += len
      blocks.push({ d, ec: rsRemainder(d, divisor) })
    }
  }
  const codewords = []
  const maxData = Math.max(...blocks.map((b) => b.d.length))
  for (let i = 0; i < maxData; i++) blocks.forEach((b) => { if (i < b.d.length) codewords.push(b.d[i]) })
  for (let i = 0; i < ecLen; i++) blocks.forEach((b) => codewords.push(b.ec[i]))

  // Function patterns.
  const size = version * 4 + 17
  const modules = Array.from({ length: size }, () => new Array(size).fill(false))
  const isFunction = Array.from({ length: size }, () => new Array(size).fill(false))
  const setFn = (x, y, dark) => { modules[y][x] = dark; isFunction[y][x] = true }

  for (let i = 0; i < size; i++) { setFn(6, i, i % 2 === 0); setFn(i, 6, i % 2 === 0) }
  const finder = (cx, cy) => {
    for (let dy = -4; dy <= 4; dy++) {
      for (let dx = -4; dx <= 4; dx++) {
        const x = cx + dx, y = cy + dy
        if (x < 0 || y < 0 || x >= size || y >= size) continue
        const dist = Math.max(Math.abs(dx), Math.abs(dy))
        setFn(x, y, dist !== 2 && dist !== 4)
      }
    }
  }
  finder(3, 3); finder(size - 4, 3); finder(3, size - 4)
  const align = QR_ALIGN[version]
  align.forEach((ay, i) => align.forEach((ax, j) => {
    const last = align.length - 1
    if ((i === 0 && j === 0) || (i === 0 && j === last) || (i === last && j === 0)) return
    for (let dy = -2; dy <= 2; dy++) {
      for (let dx = -2; dx <= 2; dx++) setFn(ax + dx, ay + dy, Math.max(Math.abs(dx), Math.abs(dy)) !== 1)
    }
  }))

  const drawFormat = (mask) => {
    const fmt = (0b00 << 3) | mask // level M = 00
    let rem = fmt
    for (let i = 0; i < 10; i++) rem = (rem << 1) ^ ((rem >>> 9) * 0x537)
    const f = ((fmt << 10) | rem) ^ 0x5412
    const bit = (i) => ((f >>> i) & 1) === 1
    for (let i = 0; i <= 5; i++) setFn(8, i, bit(i))
    setFn(8, 7, bit(6)); setFn(8, 8, bit(7)); setFn(7, 8, bit(8))
    for (let i = 9; i < 15; i++) setFn(14 - i, 8, bit(i))
    for (let i = 0; i < 8; i++) setFn(size - 1 - i, 8, bit(i))
    for (let i = 8; i < 15; i++) setFn(8, size - 15 + i, bit(i))
    setFn(8, size - 8, true) // dark module
  }
  drawFormat(0) // reserve the format areas before placing data

  if (version >= 7) {
    let rem = version
    for (let i = 0; i < 12; i++) rem = (rem << 1) ^ ((rem >>> 11) * 0x1f25)
    const v = (version << 12) | rem
    for (let i = 0; i < 18; i++) {
      const dark = ((v >>> i) & 1) === 1
      const a = size - 11 + (i % 3), b = Math.floor(i / 3)
      setFn(a, b, dark); setFn(b, a, dark)
    }
  }

  // Data placement: two-column zigzag from the bottom-right corner.
  let bitIndex = 0
  for (let right = size - 1; right >= 1; right -= 2) {
    if (right === 6) right = 5
    for (let vert = 0; vert < size; vert++) {
      for (let j = 0; j < 2; j++) {
        const x = right - j
        const upward = ((right + 1) & 2) === 0
        const y = upward ? size - 1 - vert : vert
        if (isFunction[y][x]) continue
        if (bitIndex < codewords.length * 8) {
          modules[y][x] = ((codewords[bitIndex >>> 3] >>> (7 - (bitIndex & 7))) & 1) === 1
        }
        bitIndex++
      }
    }
  }

  const MASKS = [
    (x, y) => (x + y) % 2 === 0,
    (x, y) => y % 2 === 0,
    (x) => x % 3 === 0,
    (x, y) => (x + y) % 3 === 0,
    (x, y) => (Math.floor(x / 3) + Math.floor(y / 2)) % 2 === 0,
    (x, y) => ((x * y) % 2) + ((x * y) % 3) === 0,
    (x, y) => (((x * y) % 2) + ((x * y) % 3)) % 2 === 0,
    (x, y) => (((x + y) % 2) + ((x * y) % 3)) % 2 === 0,
  ]
  const applyMask = (m) => {
    for (let y = 0; y < size; y++) {
      for (let x = 0; x < size; x++) if (!isFunction[y][x] && MASKS[m](x, y)) modules[y][x] = !modules[y][x]
    }
  }

  // Pick the mask with the lowest penalty score (rules N1–N4).
  const penalty = () => {
    let score = 0
    const line = (get) => {
      for (let a = 0; a < size; a++) {
        let run = 1
        for (let b = 1; b <= size; b++) {
          if (b < size && get(a, b) === get(a, b - 1)) { run++; continue }
          if (run >= 5) score += run - 2
          run = 1
        }
        for (let b = 0; b + 10 < size + 1; b++) {
          const seq = Array.from({ length: 11 }, (_, k) => (b + k < size ? get(a, b + k) : false))
          const pat = [true, false, true, true, true, false, true]
          const matchAt = (s) => pat.every((p, k) => seq[s + k] === p)
          if ((matchAt(0) && !seq[7] && !seq[8] && !seq[9] && !seq[10]) ||
              (matchAt(4) && !seq[0] && !seq[1] && !seq[2] && !seq[3])) score += 40
        }
      }
    }
    line((a, b) => modules[a][b])
    line((a, b) => modules[b][a])
    let dark = 0
    for (let y = 0; y < size; y++) {
      for (let x = 0; x < size; x++) {
        if (modules[y][x]) dark++
        if (x < size - 1 && y < size - 1) {
          const c = modules[y][x]
          if (c === modules[y][x + 1] && c === modules[y + 1][x] && c === modules[y + 1][x + 1]) score += 3
        }
      }
    }
    score += Math.floor(Math.abs(dark * 20 - size * size * 10) / (size * size)) * 10
    return score
  }

  let best = mask ?? 0, bestScore = Infinity
  for (let m = 0; m < 8 && mask === undefined; m++) {
    applyMask(m); drawFormat(m)
    const s = penalty()
    if (s < bestScore) { bestScore = s; best = m }
    applyMask(m) // undo (XOR)
  }
  applyMask(best); drawFormat(best)
  return modules
}

/**
 * Render a QR matrix for a terminal: one row per module, two spaces per module,
 * coloured by background only. Glyph-based rendering (half blocks) breaks when the
 * terminal adds line spacing or the font draws block characters short; background
 * colour fills the whole cell, so the code stays solid and scannable. The 4-module
 * light border is the quiet zone the QR spec requires — a dark terminal around a
 * thinner border stops phone cameras from finding the code.
 */
export function renderQR(modules, quiet = 4) {
  const size = modules.length
  const DARK = '\x1b[48;5;16m', LIGHT = '\x1b[48;5;231m', RESET = '\x1b[0m'
  const lines = []
  for (let y = -quiet; y < size + quiet; y++) {
    let row = '', prev = null
    for (let x = -quiet; x < size + quiet; x++) {
      const dark = x >= 0 && y >= 0 && x < size && y < size && modules[y][x]
      if (dark !== prev) { row += dark ? DARK : LIGHT; prev = dark }
      row += '  '
    }
    lines.push(row + RESET)
  }
  return lines.join('\n')
}

/** Render a QR matrix as an SVG, for the browser fallback page. */
export function qrSvg(modules, quiet = 4) {
  const size = modules.length, full = size + quiet * 2
  let path = ''
  modules.forEach((row, y) => row.forEach((dark, x) => { if (dark) path += `M${x + quiet} ${y + quiet}h1v1h-1z` }))
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${full} ${full}" shape-rendering="crispEdges">` +
    `<rect width="${full}" height="${full}" fill="#fff"/><path d="${path}" fill="#000"/></svg>`
}

// ---------------------------------------------------------------------------
// Minimal WebSocket server (RFC 6455): text frames, ping/pong, close.
// Messages here are small JSON objects, so fragmented frames are not supported.
// ---------------------------------------------------------------------------

function encodeFrame(opcode, payload) {
  const len = payload.length
  let header
  if (len < 126) header = Buffer.from([0x80 | opcode, len])
  else if (len < 65536) { header = Buffer.alloc(4); header[0] = 0x80 | opcode; header[1] = 126; header.writeUInt16BE(len, 2) }
  else { header = Buffer.alloc(10); header[0] = 0x80 | opcode; header[1] = 127; header.writeBigUInt64BE(BigInt(len), 2) }
  return Buffer.concat([header, payload])
}

class Socket {
  constructor(raw, role) {
    this.raw = raw
    this.role = role
    this.alive = true
    this.buffer = Buffer.alloc(0)
    this.onmessage = () => {}
    this.onclose = () => {}
    raw.on('data', (chunk) => this.#read(chunk))
    raw.on('close', () => this.onclose())
    raw.on('error', () => raw.destroy())
  }

  send(obj) {
    if (!this.raw.destroyed) this.raw.write(encodeFrame(0x1, Buffer.from(JSON.stringify(obj))))
  }

  ping() { if (!this.raw.destroyed) this.raw.write(encodeFrame(0x9, Buffer.alloc(0))) }

  close() { if (!this.raw.destroyed) { this.raw.write(encodeFrame(0x8, Buffer.alloc(0))); this.raw.end() } }

  #read(chunk) {
    this.buffer = Buffer.concat([this.buffer, chunk])
    while (this.buffer.length >= 2) {
      const opcode = this.buffer[0] & 0x0f
      const masked = (this.buffer[1] & 0x80) !== 0
      let len = this.buffer[1] & 0x7f
      let pos = 2
      if (len === 126) { if (this.buffer.length < 4) return; len = this.buffer.readUInt16BE(2); pos = 4 }
      else if (len === 127) { if (this.buffer.length < 10) return; len = Number(this.buffer.readBigUInt64BE(2)); pos = 10 }
      if (len > 1 << 20) { this.raw.destroy(); return } // nothing legitimate is this big
      const maskLen = masked ? 4 : 0
      if (this.buffer.length < pos + maskLen + len) return
      const mask = masked ? this.buffer.subarray(pos, pos + 4) : null
      const payload = Buffer.from(this.buffer.subarray(pos + maskLen, pos + maskLen + len))
      if (mask) for (let i = 0; i < payload.length; i++) payload[i] ^= mask[i & 3]
      this.buffer = this.buffer.subarray(pos + maskLen + len)

      if (opcode === 0x8) { this.close(); return }
      if (opcode === 0x9) { this.raw.write(encodeFrame(0xa, payload)); continue }
      if (opcode === 0xa) { this.alive = true; continue }
      if (opcode === 0x1) {
        try { this.onmessage(JSON.parse(payload.toString('utf8'))) } catch { /* ignore bad JSON */ }
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Relay: decks receive commands, remotes receive deck state.
// ---------------------------------------------------------------------------

const ACTIONS = new Set(['next', 'prev', 'first', 'last', 'goto'])

export function createRelay({ token = randomBytes(6).toString('hex') } = {}) {
  const decks = new Set()
  const remotes = new Set()
  let lastState = null
  let remoteUrl = null

  const presence = () => ({ type: 'presence', decks: decks.size })
  const toRemotes = (msg) => remotes.forEach((r) => r.send(msg))

  const heartbeat = setInterval(() => {
    for (const s of [...decks, ...remotes]) {
      if (!s.alive) { s.raw.destroy(); continue }
      s.alive = false
      s.ping()
    }
  }, 15000)
  heartbeat.unref()

  /** Handle an HTTP 'upgrade' event. Returns true when the request was ours. */
  function handleUpgrade(req, raw) {
    const url = new URL(req.url, 'http://x')
    if (url.pathname !== `${BASE}/ws`) return false
    const role = url.searchParams.get('role')
    const key = req.headers['sec-websocket-key']
    const authorised = role === 'deck' || (role === 'remote' && url.searchParams.get('t') === token)
    if (!key || !authorised) {
      raw.end('HTTP/1.1 403 Forbidden\r\nConnection: close\r\n\r\n')
      return true
    }
    const accept = createHash('sha1').update(key + WS_GUID).digest('base64')
    raw.write(
      'HTTP/1.1 101 Switching Protocols\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n' +
      `Sec-WebSocket-Accept: ${accept}\r\n\r\n`,
    )
    raw.setNoDelay(true)
    const socket = new Socket(raw, role)

    if (role === 'deck') {
      decks.add(socket)
      socket.onmessage = (msg) => {
        if (msg.type !== 'state') return
        lastState = {
          type: 'state',
          current: Number(msg.current) || 0,
          total: Number(msg.total) || 0,
          title: String(msg.title ?? '').slice(0, 200),
          next: msg.next == null ? null : String(msg.next).slice(0, 200),
          vw: Math.min(Math.max(Math.round(Number(msg.vw) || 0), 0), 10000),
          vh: Math.min(Math.max(Math.round(Number(msg.vh) || 0), 0), 10000),
        }
        toRemotes(lastState)
      }
      socket.onclose = () => { decks.delete(socket); toRemotes(presence()) }
      toRemotes(presence())
    } else {
      remotes.add(socket)
      socket.send(presence())
      if (lastState) socket.send(lastState)
      socket.onmessage = (msg) => {
        if (msg.type !== 'cmd' || !ACTIONS.has(msg.action)) return
        const cmd = { type: 'cmd', action: msg.action }
        if (msg.action === 'goto') cmd.index = Math.max(0, Math.floor(Number(msg.index) || 0))
        decks.forEach((d) => d.send(cmd))
      }
      socket.onclose = () => remotes.delete(socket)
    }
    return true
  }

  /** Serve the relay's own HTTP routes. Returns true when the request was ours. */
  function handleRequest(req, res) {
    const url = new URL(req.url, 'http://x')
    if (url.pathname === '/remote' || url.pathname === '/remote/') {
      res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' })
      res.end(REMOTE_HTML)
      return true
    }
    if (url.pathname === `${BASE}/qr`) {
      // The page shows the token, so only the laptop itself may open it.
      const local = /^(127\.|::1$|::ffff:127\.)/.test(req.socket.remoteAddress ?? '')
      if (!local || !remoteUrl) {
        res.writeHead(local ? 503 : 403, { 'Content-Type': 'text/plain; charset=utf-8' })
        res.end(local ? 'Remote URL not ready yet' : 'Open this page on the presenting laptop (localhost) only')
        return true
      }
      res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' })
      res.end(qrPageHtml(remoteUrl))
      return true
    }
    if (url.pathname === `${BASE}/client.js`) {
      res.writeHead(200, { 'Content-Type': 'text/javascript; charset=utf-8', 'Cache-Control': 'no-store' })
      res.end(CLIENT_JS)
      return true
    }
    return false
  }

  function close() {
    clearInterval(heartbeat)
    for (const s of [...decks, ...remotes]) s.close()
  }

  const setRemoteUrl = (u) => { remoteUrl = u }
  return { token, handleUpgrade, handleRequest, close, setRemoteUrl }
}

// ---------------------------------------------------------------------------
// Network helpers and the terminal banner.
// ---------------------------------------------------------------------------

/** LAN IPv4 addresses, most likely Wi-Fi/Ethernet first. */
export function lanAddresses() {
  const virtual = /^(docker|br-|veth|vbox|vmnet|utun|tun|tap|awdl|llw|bridge|lo|zt|tailscale)/i
  const found = []
  for (const [name, addrs] of Object.entries(networkInterfaces())) {
    for (const a of addrs ?? []) {
      if (a.family !== 'IPv4' && a.family !== 4) continue
      if (a.internal) continue
      const isPrivate = /^(10\.|192\.168\.|172\.(1[6-9]|2\d|3[01])\.)/.test(a.address)
      const rank = (virtual.test(name) ? 2 : 0) + (isPrivate ? 0 : 1)
      found.push({ name, address: a.address, rank })
    }
  }
  return found.sort((a, b) => a.rank - b.rank).map((f) => f.address)
}

export function printBanner({ port, token, host, deckUrl, log = console.log }) {
  // Returns the remote URL put in the QR code, or null when no LAN address exists.
  const addresses = host ? [host] : lanAddresses()
  const bold = (s) => `\x1b[1m${s}\x1b[0m`
  const cyan = (s) => `\x1b[36m${s}\x1b[0m`
  const dim = (s) => `\x1b[2m${s}\x1b[0m`
  log('')
  log(bold('  📱 Slidewright remote'))
  if (deckUrl) log(`  Deck (open on the laptop):  ${cyan(deckUrl)}`)
  if (addresses.length === 0) {
    log('  No LAN address found. Join the same Wi-Fi as the phone (or start a hotspot), then restart.')
    log(`  Remote on this machine:     ${cyan(`http://localhost:${port}/remote?t=${token}`)}`)
    log('')
    return null
  }
  const remoteUrl = `http://${addresses[0]}:${port}/remote?t=${token}`
  log(`  Remote (scan with phone):   ${cyan(remoteUrl)}`)
  for (const other of addresses.slice(1)) log(dim(`  Other address:              http://${other}:${port}/remote?t=${token}`))
  log('')
  log(renderQR(encodeQR(remoteUrl)).replace(/^/gm, '  '))
  log('')
  log(`  QR not scanning? Open on this laptop: ${cyan(`http://localhost:${port}${BASE}/qr`)}`)
  log(dim('  Phone and laptop must be on the same network. Anyone with this URL can change slides.'))
  log('')
  return remoteUrl
}

// ---------------------------------------------------------------------------
// Vite plugin (React track).
// ---------------------------------------------------------------------------

export function slidewrightRemote(options = {}) {
  const relay = createRelay({ token: options.token ?? process.env.SLIDEWRIGHT_TOKEN })
  return {
    name: 'slidewright-remote',
    apply: 'serve',
    // Listen on the LAN so the phone can reach the dev server.
    config: (config) => (config.server?.host === undefined ? { server: { host: true } } : undefined),
    configureServer(server) {
      server.middlewares.use((req, res, next) => { if (!relay.handleRequest(req, res)) next() })
      const http = server.httpServer
      if (!http) return
      http.on('upgrade', (req, socket) => { relay.handleUpgrade(req, socket) })
      http.once('listening', () => {
        // Print after Vite's own URL banner so the QR code is the last thing on screen.
        setTimeout(() => {
          const { port } = http.address()
          relay.setRemoteUrl(printBanner({ port, token: relay.token, host: options.host ?? process.env.SLIDEWRIGHT_HOST }))
        }, 150)
      })
      http.once('close', () => relay.close())
    },
    transformIndexHtml: () => [{ tag: 'script', attrs: { src: `${BASE}/client.js`, defer: true }, injectTo: 'body' }],
  }
}

// ---------------------------------------------------------------------------
// Static server (plain-HTML track).
// ---------------------------------------------------------------------------

// Only web assets are served. Markdown (speaker notes) and scripts like this one stay private.
const MIME = {
  '.html': 'text/html; charset=utf-8', '.css': 'text/css; charset=utf-8', '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json', '.svg': 'image/svg+xml', '.png': 'image/png', '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg', '.gif': 'image/gif', '.webp': 'image/webp', '.avif': 'image/avif', '.ico': 'image/x-icon',
  '.woff': 'font/woff', '.woff2': 'font/woff2', '.ttf': 'font/ttf', '.otf': 'font/otf',
  '.mp4': 'video/mp4', '.webm': 'video/webm', '.mp3': 'audio/mpeg', '.wav': 'audio/wav', '.pdf': 'application/pdf',
}

export async function serveDeck({ root, port = 8000, host, token } = {}) {
  const base = resolve(root)
  const relay = createRelay({ token })
  const server = createServer(async (req, res) => {
    if (relay.handleRequest(req, res)) return
    try {
      let path = decodeURIComponent(new URL(req.url, 'http://x').pathname)
      if (path.endsWith('/')) path += 'index.html'
      const file = normalize(join(base, path))
      if (file !== base && !file.startsWith(base + sep)) throw Object.assign(new Error(), { code: 'EACCES' })
      const type = MIME[extname(file).toLowerCase()]
      if (!type) throw Object.assign(new Error(), { code: 'ENOENT' })
      if (!(await stat(file)).isFile()) throw Object.assign(new Error(), { code: 'ENOENT' })
      let body = await readFile(file)
      if (type.startsWith('text/html')) {
        const tag = `<script src="${BASE}/client.js" defer></script>`
        const html = body.toString('utf8')
        body = Buffer.from(html.includes('</body>') ? html.replace('</body>', `${tag}\n</body>`) : html + tag)
      }
      res.writeHead(200, { 'Content-Type': type, 'Cache-Control': 'no-cache' })
      res.end(body)
    } catch (err) {
      const code = err.code === 'EACCES' ? 403 : 404
      res.writeHead(code, { 'Content-Type': 'text/plain; charset=utf-8' })
      res.end(code === 403 ? 'Forbidden' : 'Not found')
    }
  })
  server.on('upgrade', (req, socket) => { if (!relay.handleUpgrade(req, socket)) socket.destroy() })

  // Try the requested port, then the next few if it is taken.
  for (let p = port; p < port + 20; p++) {
    const ok = await new Promise((done) => {
      server.once('error', (e) => { if (e.code === 'EADDRINUSE') done(false); else throw e })
      server.listen(p, '0.0.0.0', () => done(true))
    })
    if (ok) {
      relay.setRemoteUrl(printBanner({ port: p, token: relay.token, host, deckUrl: `http://localhost:${p}/` }))
      return { server, relay, port: p }
    }
  }
  throw new Error(`No free port between ${port} and ${port + 19}`)
}

// ---------------------------------------------------------------------------
// Browser code: deck client and phone remote page.
// ---------------------------------------------------------------------------

const CLIENT_JS = `(() => {
  if (window.__slidewrightRemote) return;
  window.__slidewrightRemote = true;
  const api = () => window.slidewright;

  // Preview mode: the phone remote embeds the deck in iframes to show the current and
  // next slide. A preview never joins the relay; the parent page picks its slide.
  if (new URLSearchParams(location.search).has('__swpreview')) {
    let want = null;
    const apply = () => { const a = api(); if (a && want !== null) a.go(want); };
    window.addEventListener('message', (e) => {
      if (e.source !== parent || !e.data || e.data.type !== 'sw-preview-go') return;
      want = e.data.index;
      apply();
    });
    // The React deck sets window.slidewright in an effect, so wait for it to appear.
    const wait = setInterval(() => {
      if (!api()) return;
      clearInterval(wait);
      apply();
      parent.postMessage({ type: 'sw-preview-ready' }, location.origin);
    }, 100);
    setTimeout(() => clearInterval(wait), 15000);
    // Report what the preview shows, so the remote can name the next slide even when
    // the deck cannot (the React deck only knows titles of rendered slides).
    window.addEventListener('slidewright:change', () => {
      const st = api() && api().getState();
      if (st) parent.postMessage({ type: 'sw-preview-state', index: st.current, title: st.title }, location.origin);
    });
    return;
  }

  const url = (location.protocol === 'https:' ? 'wss://' : 'ws://') + location.host + '${BASE}/ws?role=deck';
  let ws = null, delay = 500, resizeTimer = null;
  const key = (k) => window.dispatchEvent(new KeyboardEvent('keydown', { key: k, bubbles: true }));
  function sendState() {
    const a = api();
    if (!a || !ws || ws.readyState !== 1) return;
    // The window size lets the remote draw previews with the projected aspect ratio.
    const state = Object.assign({ type: 'state' }, a.getState(), { vw: innerWidth, vh: innerHeight });
    try { ws.send(JSON.stringify(state)); } catch (e) {}
  }
  function run(cmd) {
    const a = api();
    if (cmd.action === 'next') a ? a.next() : key('ArrowRight');
    else if (cmd.action === 'prev') a ? a.prev() : key('ArrowLeft');
    else if (cmd.action === 'first') a ? a.go(0) : key('Home');
    else if (cmd.action === 'last') a ? a.go(a.getState().total - 1) : key('End');
    else if (cmd.action === 'goto' && a) a.go(cmd.index);
  }
  function connect() {
    ws = new WebSocket(url);
    ws.onopen = () => { delay = 500; sendState(); };
    ws.onmessage = (e) => { try { const m = JSON.parse(e.data); if (m.type === 'cmd') run(m); } catch (err) {} };
    ws.onclose = () => { setTimeout(connect, delay); delay = Math.min(delay * 2, 5000); };
  }
  window.addEventListener('slidewright:change', sendState);
  window.addEventListener('resize', () => { clearTimeout(resizeTimer); resizeTimer = setTimeout(sendState, 300); });
  connect();
})();
`

const escapeHtml = (s) => s.replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' })[c])

function qrPageHtml(remoteUrl) {
  return `<!doctype html>
<html lang="vi"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Remote QR</title>
<style>
  html, body { margin:0; height:100%; background:#fff; color:#111; font-family:system-ui,-apple-system,sans-serif; }
  body { display:flex; flex-direction:column; align-items:center; justify-content:center; gap:24px; padding:16px; box-sizing:border-box; }
  .qr { width:min(70vh, 90vw); }
  .qr svg { display:block; width:100%; height:auto; }
  code { font-size:clamp(14px, 2vw, 22px); word-break:break-all; text-align:center; }
</style></head>
<body>
  <div class="qr">${qrSvg(encodeQR(remoteUrl))}</div>
  <p>Quét bằng camera điện thoại (cùng Wi-Fi với laptop)</p>
  <code>${escapeHtml(remoteUrl)}</code>
</body></html>`
}

const REMOTE_HTML = `<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, viewport-fit=cover, user-scalable=no">
<meta name="theme-color" content="#0f1115">
<title>Slide remote</title>
<style>
  :root { --bg:#0f1115; --panel:#1a1d24; --ink:#f2f2f2; --soft:#9aa0aa; --accent:#e0915f; --ok:#4cc38a; --warn:#e5b442; --bad:#e5534b; --ar:1.7778; }
  * { box-sizing:border-box; margin:0; padding:0; -webkit-tap-highlight-color:transparent; }
  /* No browser zoom or panning anywhere: a stray double tap must never zoom the remote
     mid-talk. Swipes still work, they use JS touch events. */
  html, body, body * { touch-action:none; }
  html, body { height:100%; background:var(--bg); color:var(--ink); font-family:system-ui,-apple-system,sans-serif; overscroll-behavior:none; }
  body {
    height:100dvh; display:flex; flex-direction:column; gap:12px; overflow:hidden;
    padding:max(12px, env(safe-area-inset-top)) max(16px, env(safe-area-inset-right)) max(16px, env(safe-area-inset-bottom)) max(16px, env(safe-area-inset-left));
    user-select:none; -webkit-user-select:none;
  }
  header { display:flex; align-items:center; justify-content:space-between; gap:12px; font-size:14px; color:var(--soft); }
  .status { display:flex; align-items:center; gap:8px; min-width:0; }
  .status span:last-child { overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
  .dot { flex:none; width:10px; height:10px; border-radius:50%; background:var(--bad); }
  .dot.ok { background:var(--ok); } .dot.warn { background:var(--warn); }
  .timer { flex:none; display:flex; gap:6px; }
  .timer button { background:var(--panel); color:var(--ink); border:0; border-radius:10px; padding:8px 12px; font-size:16px; font-weight:700; font-variant-numeric:tabular-nums; }
  .timer button.running { color:var(--accent); }

  .main { display:flex; flex-direction:column; gap:12px; flex:1; min-height:0; }
  .side { display:flex; flex-direction:column; gap:12px; flex:1; min-height:0; }

  /* Live previews: the deck itself in an iframe, rendered at the projector's window
     size and scaled down, so the phone shows exactly what the room sees. */
  .frame { position:relative; width:100%; aspect-ratio:var(--ar); overflow:hidden; border-radius:12px; background:#000; flex:none; }
  .frame iframe { position:absolute; left:0; top:0; border:0; transform-origin:0 0; pointer-events:none; background:#fff; }
  .frame .empty { position:absolute; inset:0; display:none; align-items:center; justify-content:center; color:var(--soft); font-size:15px; background:var(--panel); }
  .frame.end iframe { visibility:hidden; }
  .frame.end .empty { display:flex; }
  .current .frame { box-shadow:0 0 0 2px var(--accent); }

  .meta { display:flex; align-items:center; gap:12px; min-width:0; }
  .counter { position:relative; flex:none; background:var(--panel); border-radius:10px; padding:6px 12px; font-size:18px; font-weight:800; font-variant-numeric:tabular-nums; }
  .counter select { position:absolute; inset:0; opacity:0; width:100%; font-size:16px; }
  .title { font-size:17px; font-weight:700; line-height:1.25; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; }

  .next { display:grid; grid-template-columns:52% 1fr; gap:12px; align-items:center; }
  .next .label { font-size:12px; letter-spacing:.08em; text-transform:uppercase; color:var(--soft); margin-bottom:4px; }
  .next .title { font-size:15px; font-weight:600; color:var(--soft); -webkit-line-clamp:3; }

  .controls { flex:1; min-height:84px; display:grid; grid-template-columns:1fr 2fr; gap:12px; }
  .controls button { border:0; border-radius:18px; font-size:24px; font-weight:800; color:var(--ink); background:var(--panel); }
  .controls button:active { transform:scale(.98); filter:brightness(1.3); }
  #nextBtn { background:var(--accent); color:#1b120c; font-size:30px; }
  button:disabled { opacity:.35; }

  /* No deck API (old deck): previews cannot follow, so show titles only. */
  .no-preview .frame { display:none; }
  .no-preview .current .title { font-size:22px; }

  /* Landscape phone: current slide left, next slide and buttons right. */
  @media (orientation: landscape) {
    .main { flex-direction:row; }
    .current { flex:1.5; min-width:0; display:flex; flex-direction:column; gap:12px; }
    .current .frame { width:min(100%, calc((100dvh - 120px) * var(--ar))); }
    .side { flex:1; min-width:0; }
    .next { grid-template-columns:1fr; }
    .next .frame { width:min(100%, calc((100dvh - 120px) * var(--ar) * .4)); }
  }
</style>
</head>
<body>
  <header>
    <div class="status"><span class="dot" id="dot"></span><span id="status">Đang kết nối…</span></div>
    <div class="timer">
      <button id="clock" aria-label="Bắt đầu / tạm dừng đồng hồ">▶ 00:00</button>
      <button id="resetBtn" aria-label="Đặt lại đồng hồ">↺</button>
    </div>
  </header>

  <div class="main">
    <section class="current">
      <div class="frame" id="curFrame">
        <iframe id="curView" title="Slide hiện tại" tabindex="-1"></iframe>
        <div class="empty">Đang tải…</div>
      </div>
      <div class="meta">
        <label class="counter"><span id="counter">– / –</span><select id="gotoSel" aria-label="Đến slide"></select></label>
        <div class="title" id="title"></div>
      </div>
    </section>

    <div class="side">
      <section class="next">
        <div class="frame" id="nextFrame">
          <iframe id="nextView" title="Slide tiếp theo" tabindex="-1"></iframe>
          <div class="empty">Hết slide</div>
        </div>
        <div>
          <div class="label">Tiếp theo</div>
          <div class="title" id="nextTitle"></div>
        </div>
      </section>
      <section class="controls">
        <button id="prevBtn" aria-label="Slide trước">‹ Trước</button>
        <button id="nextBtn" aria-label="Slide sau">Sau ›</button>
      </section>
    </div>
  </div>
<script>
(() => {
  const token = new URLSearchParams(location.search).get('t') || '';
  const $ = (id) => document.getElementById(id);
  const wsUrl = (location.protocol === 'https:' ? 'wss://' : 'ws://') + location.host + '${BASE}/ws?role=remote&t=' + encodeURIComponent(token);
  let ws = null, delay = 500, state = null, decks = 0, failures = 0;
  let deckW = 1280, deckH = 720;
  const previewTitles = {}; // slide index -> title, as reported by the preview iframes

  // --- Previews -----------------------------------------------------------
  const views = [
    { frame: $('curFrame'), iframe: $('curView'), offset: 0, ready: false },
    { frame: $('nextFrame'), iframe: $('nextView'), offset: 1, ready: false },
  ];
  function fit() {
    document.documentElement.style.setProperty('--ar', String(deckW / deckH));
    views.forEach((v) => {
      v.iframe.style.width = deckW + 'px';
      v.iframe.style.height = deckH + 'px';
      v.iframe.style.transform = 'scale(' + (v.frame.clientWidth / deckW) + ')';
    });
  }
  function showSlides() {
    if (!state) return;
    views.forEach((v) => {
      const index = state.current + v.offset;
      v.frame.classList.toggle('end', index >= state.total);
      if (v.ready && index < state.total) v.iframe.contentWindow.postMessage({ type: 'sw-preview-go', index }, location.origin);
    });
  }
  window.addEventListener('message', (e) => {
    if (e.origin !== location.origin || !e.data) return;
    const v = views.find((x) => x.iframe.contentWindow === e.source);
    if (!v) return;
    if (e.data.type === 'sw-preview-ready') { v.ready = true; showSlides(); }
    // A preview has rendered its slide: remember the title, used when the deck sends no
    // next-slide title (React deck).
    if (e.data.type === 'sw-preview-state' && e.data.title) {
      previewTitles[e.data.index] = String(e.data.title);
      if (state && !state.next && e.data.index === state.current + 1) $('nextTitle').textContent = previewTitles[e.data.index];
    }
  });
  views.forEach((v) => { v.iframe.src = '/?__swpreview=' + v.offset; });
  new ResizeObserver(fit).observe(document.body);
  // A deck without the window.slidewright API cannot be previewed: fall back to titles.
  setTimeout(() => { if (!views[0].ready) document.body.classList.add('no-preview'); }, 8000);

  // --- Connection and state -----------------------------------------------
  function setStatus() {
    const open = ws && ws.readyState === 1;
    // Several failed tries in a row: the server is down, or it restarted with a new token.
    const stale = !open && failures >= 4;
    $('dot').className = 'dot' + (open ? (decks > 0 ? ' ok' : ' warn') : '');
    $('status').textContent = open ? (decks > 0 ? 'Đã kết nối' : 'Chưa mở deck trên máy chiếu')
      : stale ? 'Không kết nối được – nếu đã chạy lại server, quét lại mã QR mới' : 'Mất kết nối – đang thử lại…';
    const enabled = open && decks > 0;
    ['prevBtn', 'nextBtn', 'gotoSel'].forEach((id) => { $(id).disabled = !enabled; });
  }
  function render() {
    if (!state) return;
    $('counter').textContent = (state.current + 1) + ' / ' + state.total;
    $('title').textContent = state.title || 'Slide ' + (state.current + 1);
    const last = state.current + 1 >= state.total;
    $('nextTitle').textContent = last ? 'Đây là slide cuối' : (state.next || previewTitles[state.current + 1] || 'Slide ' + (state.current + 2));
    $('prevBtn').disabled ||= state.current === 0;
    $('nextBtn').disabled ||= last;
    const sel = $('gotoSel');
    if (sel.options.length !== state.total) {
      sel.innerHTML = '';
      for (let i = 0; i < state.total; i++) sel.add(new Option('Slide ' + (i + 1), String(i)));
    }
    sel.value = String(state.current);
    if (state.vw > 0 && state.vh > 0 && (state.vw !== deckW || state.vh !== deckH)) { deckW = state.vw; deckH = state.vh; fit(); }
    showSlides();
  }
  function send(action, index) {
    if (!ws || ws.readyState !== 1) return;
    ws.send(JSON.stringify({ type: 'cmd', action, index }));
    if (navigator.vibrate) navigator.vibrate(12);
  }
  function connect() {
    if (ws && ws.readyState <= 1) return;
    ws = new WebSocket(wsUrl);
    ws.onopen = () => { delay = 500; failures = 0; setStatus(); };
    ws.onmessage = (e) => {
      const m = JSON.parse(e.data);
      if (m.type === 'presence') decks = m.decks;
      if (m.type === 'state') { state = m; decks = Math.max(decks, 1); }
      setStatus(); render();
    };
    ws.onclose = () => { failures++; setStatus(); setTimeout(connect, delay); delay = Math.min(delay * 2, 5000); };
  }

  $('prevBtn').onclick = () => send('prev');
  $('nextBtn').onclick = () => send('next');
  $('gotoSel').onchange = (e) => send('goto', Number(e.target.value));

  // Horizontal swipe anywhere (previews ignore touches): left = next, right = previous.
  let sx = 0, sy = 0;
  addEventListener('touchstart', (e) => { sx = e.touches[0].clientX; sy = e.touches[0].clientY; }, { passive: true });
  addEventListener('touchend', (e) => {
    const dx = e.changedTouches[0].clientX - sx, dy = e.changedTouches[0].clientY - sy;
    if (Math.abs(dx) > 60 && Math.abs(dx) > Math.abs(dy) * 1.5) send(dx < 0 ? 'next' : 'prev');
  }, { passive: true });

  // --- Talk timer, kept on the phone only ---------------------------------
  let started = 0, elapsed = 0, tick = null;
  const fmt = (ms) => { const s = Math.floor(ms / 1000); return String(Math.floor(s / 60)).padStart(2, '0') + ':' + String(s % 60).padStart(2, '0'); };
  const show = () => {
    $('clock').textContent = (tick ? '❚❚ ' : '▶ ') + fmt(elapsed + (tick ? Date.now() - started : 0));
    $('clock').classList.toggle('running', !!tick);
  };
  $('clock').onclick = () => {
    if (tick) { elapsed += Date.now() - started; clearInterval(tick); tick = null; }
    else { started = Date.now(); tick = setInterval(show, 500); }
    show();
  };
  $('resetBtn').onclick = () => { elapsed = 0; started = Date.now(); show(); };

  // iOS Safari ignores user-scalable=no and still zooms on a double tap or pinch.
  // Cancel the second tap of a quick pair. That also cancels its click, so replay
  // the click on a button: two fast taps on Next must still move two slides.
  let lastTap = 0, tapX = 0, tapY = 0;
  addEventListener('touchstart', (e) => { tapX = e.touches[0].clientX; tapY = e.touches[0].clientY; }, { passive: true });
  addEventListener('touchend', (e) => {
    const t = e.changedTouches[0], now = Date.now();
    const isTap = Math.abs(t.clientX - tapX) < 10 && Math.abs(t.clientY - tapY) < 10;
    if (isTap && now - lastTap < 350) {
      e.preventDefault();
      const btn = e.target.closest && e.target.closest('button');
      if (btn && !btn.disabled) btn.click();
    }
    if (isTap) lastTap = now;
  }, { passive: false });
  ['gesturestart', 'gesturechange', 'dblclick'].forEach((type) => addEventListener(type, (e) => e.preventDefault(), { passive: false }));

  // Phones drop sockets when the screen locks; reconnect when it comes back.
  document.addEventListener('visibilitychange', () => { if (!document.hidden) connect(); });
  // Keep the screen awake where the browser allows it (needs HTTPS on most phones).
  if (navigator.wakeLock) navigator.wakeLock.request('screen').catch(() => {});

  fit();
  setStatus();
  connect();
})();
</script>
</body>
</html>
`

// ---------------------------------------------------------------------------
// CLI entry point.
// ---------------------------------------------------------------------------

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const args = process.argv.slice(2)
  const opts = { root: dirname(fileURLToPath(import.meta.url)) }
  for (let i = 0; i < args.length; i++) {
    const a = args[i]
    if (a === '--port') opts.port = Number(args[++i])
    else if (a === '--host') opts.host = args[++i]
    else if (a === '--token') opts.token = args[++i]
    else if (a === '-h' || a === '--help') {
      console.log('Usage: node slidewright-remote.mjs [deck-dir] [--port 8000] [--host <lan-ip>] [--token <token>]')
      process.exit(0)
    } else opts.root = a
  }
  opts.token ??= process.env.SLIDEWRIGHT_TOKEN
  opts.host ??= process.env.SLIDEWRIGHT_HOST
  serveDeck(opts).catch((err) => { console.error(err.message); process.exit(1) })
}
