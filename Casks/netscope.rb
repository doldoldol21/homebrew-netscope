cask "netscope" do
  version "0.1.1"
  sha256 "0d909817c119e752dd41bec5519bffaf0a7fbe4dfae04f8d3a4b0119f964428b"

  url "https://github.com/doldoldol21/netscope/releases/download/v#{version}/netscope-v#{version}-app.zip"
  name "netscope"
  desc "Per-app network traffic monitor for macOS (menu bar + dashboard)"
  homepage "https://github.com/doldoldol21/netscope"

  depends_on macos: :big_sur

  app "netscope.app"

  uninstall quit:      "io.netscope.app",
            launchctl: "io.netscope.daemon",
            delete:    "/Library/LaunchDaemons/io.netscope.daemon.plist"

  zap trash: [
    "~/Library/LaunchAgents/io.netscope.bar.plist",
    "~/Library/Application Support/netscope",
  ]

  caveats <<~EOS
    netscope is not notarized yet, so on first launch macOS Gatekeeper blocks it:
      → right-click netscope.app in /Applications and choose Open (just once).

    On first launch it asks for your admin password once to install the capture
    helper (a LaunchDaemon). After that it starts automatically at boot and the
    live ↓↑ rate appears in your menu bar.
  EOS
end
