cask "netscope" do
  version "0.13.0"
  sha256 "0792e7d43572051076ffe22f78227fb4963bbd2f1cf7370876db23dca7ca19f9"

  url "https://github.com/doldoldol21/netscope/releases/download/v#{version}/netscope-v#{version}-app.zip"
  name "netscope"
  desc "Per-app network traffic monitor for macOS"
  homepage "https://github.com/doldoldol21/netscope"

  depends_on macos: ">= :big_sur"

  app "netscope.app"

  # The app ships a root daemon (netscoped) inside the bundle, managed by launchd.
  # No postflight needed — the app sets up the daemon on first launch.
  # Uninstall removes the app but the daemon remains; see README for cleanup.

  zap trash: [
    "/var/db/netscope",
    "/var/run/netscope",
    "~/Library/LaunchAgents/io.netscope.app.plist",
    "/Library/LaunchDaemons/io.netscope.daemon.plist",
  ]
end
