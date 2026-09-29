cask "netscope" do
  version "0.30.5"
  sha256 "a944b5e9df92ddeb7e103ac1da8eaab7f813f8ba6ae81943b2c2c8fc3c52459d"

  url "https://github.com/doldoldol21/netscope/releases/download/v#{version}/netscope-v#{version}-app.zip"
  name "netscope"
  desc "Per-app network traffic monitor for macOS"
  homepage "https://github.com/doldoldol21/netscope"

  depends_on macos: :big_sur

  app "netscope.app"

  # No `uninstall quit:`. Homebrew quits through JXA's Application(<bundle id>),
  # which reads an id ending in ".app" as an app *name*: once the app has quit
  # the lookup fails, Homebrew times out on "did not quit" and never reopens
  # it. The app instead relaunches itself when its bundle is replaced.

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
