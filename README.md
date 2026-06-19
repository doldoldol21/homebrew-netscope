# homebrew-netscope

Homebrew tap for [netscope](https://github.com/doldoldol21/netscope).

The app is easiest to install with the one-line installer (no Gatekeeper prompt):

```sh
curl -fsSL https://raw.githubusercontent.com/doldoldol21/netscope/main/install.sh | bash
```

This tap provides the **CLI / daemon**, built from source:

```sh
brew install doldoldol21/netscope/netscope-cli
```

Gives `netscoped`, `netscope` and `netscope-bar`. Manage the capture daemon with
`sudo brew services start netscope-cli`.
