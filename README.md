# homebrew-netscope

Homebrew tap for [netscope](https://github.com/doldoldol21/netscope) — a per-app
network traffic monitor for macOS.

## App (recommended)

```sh
brew install --cask doldoldol21/netscope/netscope
```

Installs **netscope.app** to `/Applications`. Launch it — it lives in the menu
bar, installs its capture helper on first run (one admin prompt), and shows your
live ↓/↑ rate. (Not notarized yet: first launch needs right-click → Open.)

## CLI / daemon only

```sh
brew install doldoldol21/netscope/netscope-cli
```

Builds `netscoped`, `netscope` and `netscope-bar` from source.
