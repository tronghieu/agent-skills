# Phone remote control

The presenter changes slides from a phone. The laptop runs a small local server.
The terminal prints a QR code. The phone scans it and opens a remote page with
big Prev/Next buttons. Commands travel over a WebSocket on the local network.
No internet, no account, no npm package.

Everything lives in one zero-dependency file, `slidewright-remote.mjs` (Node 18+).
The scaffolds copy it into every new deck.

## Run it

| Track | Command | Where the QR prints |
| --- | --- | --- |
| Plain HTML | `node <deck>/slidewright-remote.mjs` | After the server starts (default port 8000, next free port if taken) |
| Vite + React | `npm run dev` | Under Vite's own Local/Network URLs |

Then:

1. Open the deck on the laptop through the server: `http://localhost:<port>/`.
   For the HTML track, opening `index.html` as a file still works but has no remote.
2. Scan the QR code with the phone camera. The phone must be on the same Wi-Fi.
   If the terminal QR code does not scan, open `http://localhost:<port>/__slidewright/qr`
   on the laptop. It shows the same code as a large image. That page answers only
   requests from the laptop itself, because it shows the token.
3. The remote shows a green dot and the slide counter when the deck is connected.

Options (HTML track flags; React track uses the environment variables):

- `--port <n>` — start port (HTML only; React uses Vite's `--port`).
- `--host <ip>` / `SLIDEWRIGHT_HOST` — LAN address for the QR code, when
  auto-detection picks the wrong network interface.
- `--token <t>` / `SLIDEWRIGHT_TOKEN` — fixed token, so a bookmarked remote URL
  survives a server restart. The default is a new random token on each run.

## What the phone remote does

- A live preview of the current slide, and a smaller preview of the next slide
  below it ("Hết slide" on the last one). Landscape puts them side by side.
- Back / Next buttons (Next is the big one), plus a horizontal swipe anywhere.
- Slide counter with a "jump to slide" picker (tap the counter), current and
  next slide titles.
- A talk timer in the header (tap to start / pause, ↺ to reset). It runs on the
  phone only.
- A status dot: green = connected, yellow = deck not open, red = reconnecting.
- Auto-reconnect when the phone screen wakes up.

The remote page is presenter tooling, not projected content. The projection
typography rules in `design-system.md` do not apply to it. Do not restyle it
to match the deck.

## How it works

```
phone /remote?t=TOKEN ──ws role=remote──▶ relay ──ws role=deck──▶ deck page
        ◀──────────── state (counter, title) ◀───────────────────
```

- The previews are the deck itself, loaded in two iframes with `?__swpreview`.
  They render at the projector window's size (the deck reports it) and are scaled
  down, so they match what the room sees. A preview never joins the relay: the
  remote page tells it which slide to show through `postMessage`, and the preview
  reports back that slide's title. That is how the React track gets a next-slide
  title. The phone loads the deck twice, so heavy video or 3D slides cost phone
  battery.
- The server injects `<script src="/__slidewright/client.js">` into the deck's
  HTML. The deck source does not load it, so the deck file stays standalone.
- The relay forwards only `next`, `prev`, `first`, `last`, `goto`. Remote
  connections without the right token get HTTP 403.
- The React plugin uses `apply: 'serve'`. It adds nothing to `npm run build`.
- The HTML server serves only web asset types. It never serves `.md` files
  (speaker notes) or the `.mjs` server itself.

## Deck contract

The injected client drives the deck through this API. Both scaffolds include it.

```js
window.slidewright = {
  go(i), next(), prev(),
  getState() // -> { current, total, title, next }   next: next slide's title or null
}
// after every slide change:
window.dispatchEvent(new CustomEvent('slidewright:change'))
```

If a deck lacks the API, the client falls back to simulated ArrowRight /
ArrowLeft / Home / End keydowns. Next and prev still work, but the phone shows
no counter, title, or previews. After 8 seconds without the API, the remote
hides the previews.

When you edit navigation code, keep these two pieces. In the React `Deck`, the
title is read from the DOM (`[data-slide="<index>"]`), so the change is
announced again from `onAnimationComplete` after the cross-fade mounts the new slide.

## Add it to an existing deck

```bash
bash /mnt/skills/user/slidewright/scripts/add-remote.sh <path-to-deck>
```

The script copies the server file and lists the remaining manual edits (the
Vite plugin line, the deck API). Make those edits with the snippets above.

## Troubleshooting

| Symptom | Cause and fix |
| --- | --- |
| Phone cannot open the URL | Not on the same network, or the venue Wi-Fi isolates clients. Use a phone hotspot and connect the laptop to it. Allow Node through the macOS/Windows firewall prompt. |
| QR code points to the wrong IP | Several interfaces (VPN, Docker). The terminal lists other addresses. Restart with `--host <ip>` or `SLIDEWRIGHT_HOST=<ip>`. |
| Yellow dot: "Chưa mở deck trên máy chiếu" | The deck is not open through the server. Open `http://localhost:<port>/`, not the file. |
| "Không kết nối được…" after a restart | The token changed. Scan the new QR code, or use a fixed `--token`. |
| Buttons work, but no counter, title, or previews | The deck is missing the `window.slidewright` API. Add it (see above). |
| Previews blank or stuck on slide 1 | The deck has a script error in preview mode, or loads slowly on the phone. Open `http://<lan-ip>:<port>/?__swpreview` on the phone to see it alone. |
| QR code does not scan | Open `http://localhost:<port>/__slidewright/qr` on the laptop and scan the large code there. The terminal code is drawn with background colours and a 4-module quiet zone. If it is cut off, enlarge the terminal window (about 45 rows). |
