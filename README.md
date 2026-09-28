# homebrew-netscope

Homebrew tap for [netscope](https://github.com/doldoldol21/netscope).

The app is easiest to install with the one-line installer (no Gatekeeper prompt):

```sh
curl -fsSL https://raw.githubusercontent.com/doldoldol21/netscope/main/install.sh | bash
```

Or install the app as a cask:

```sh
brew install --cask doldoldol21/netscope/netscope
```

This tap also provides the **CLI / daemon** built from source, for a terminal-only
setup without the menu-bar app:

```sh
brew install doldoldol21/netscope/netscope-cli
```

Gives `netscoped` and `netscope`. Manage the capture daemon with
`sudo brew services start netscope-cli`.

Both follow netscope's GitHub Releases automatically: a scheduled workflow in
this repo bumps the cask and the formula to the latest tag.
