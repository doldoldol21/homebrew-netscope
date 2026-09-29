cask "netscope" do
  version "0.30.4"
  sha256 "eda63b87e3abc1541212834f5c242f1a72994bbc2df18c08f699bd7590eb36ca"

  url "https://github.com/doldoldol21/netscope/releases/download/v#{version}/netscope-v#{version}-app.zip"
  name "netscope"
  desc "Per-app network traffic monitor for macOS"
  homepage "https://github.com/doldoldol21/netscope"

  depends_on macos: :big_sur

  app "netscope.app"

  # Quit the running menu-bar app before its bundle is replaced; on upgrade,
  # Homebrew reopens what it quit once the new version is in place. Without
  # this the old build kept running over the new bundle.
  uninstall quit: "io.netscope.app"

  # The app ships a root daemon (netscoped) inside the bundle; on first launch it
  # installs a root-owned copy under /Library/PrivilegedHelperTools and a launchd
  # service (one admin prompt). Later releases refresh that copy without a prompt.
  # Uninstall removes the app but the daemon remains; see README for cleanup.
  # version + sha256 above are kept current by .github/workflows/bump.yml.

  zap trash: [
    "/var/db/netscope",
    "/var/run/netscope",
    "~/Library/LaunchAgents/io.netscope.app.plist",
    "~/Library/Application Support/netscope",
    "/Library/LaunchDaemons/io.netscope.daemon.plist",
    "/Library/PrivilegedHelperTools/io.netscope.daemon",
  ]
end
