// Types for slidewright-remote.mjs, so `tsc -b` accepts the import in vite.config.ts.
import type { Plugin } from 'vite'

export interface SlidewrightRemoteOptions {
  /** Fixed token for the remote URL. Defaults to $SLIDEWRIGHT_TOKEN, else random per run. */
  token?: string
  /** LAN address to put in the QR code. Defaults to $SLIDEWRIGHT_HOST, else auto-detected. */
  host?: string
}

export function slidewrightRemote(options?: SlidewrightRemoteOptions): Plugin
export function encodeQR(text: string, options?: { mask?: number }): boolean[][]
export function renderQR(modules: boolean[][], quiet?: number): string
export function qrSvg(modules: boolean[][], quiet?: number): string
export function lanAddresses(): string[]
