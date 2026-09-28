cask "netscope" do
  version "0.30.0"
  sha256 "9e62dbce7ec627b69163de39d933771c59679b7676f819f1d9e2cbabe2bd7561"

  url "https://github.com/doldoldol21/netscope/releases/download/v#{version}/netscope-v#{version}-app.zip"
  name "netscope"
  desc "Per-app network traffic monitor for macOS"
  homepage "https://github.com/doldoldol21/netscope"

  depends_on macos: ">= :big_sur"

  app "netscope.app"

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
