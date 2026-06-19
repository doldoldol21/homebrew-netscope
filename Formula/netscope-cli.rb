class NetscopeCli < Formula
  desc "Per-app network traffic monitor for macOS (menu bar + dashboard)"
  homepage "https://github.com/doldoldol21/netscope"
  url "https://github.com/doldoldol21/netscope/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "fa94415a9118c9ae5366dc5c1bf0e44c0e6a24496806cda8eb6e5ac52b67e35c"
  license "MIT"
  head "https://github.com/doldoldol21/netscope.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = "-s -w -X github.com/doldoldol21/netscope/internal/buildinfo.Version=v#{version}"
    %w[netscoped netscope netscope-bar].each do |cmd|
      system "go", "build", *std_go_args(ldflags: ldflags, output: bin/cmd), "./cmd/#{cmd}"
    end
  end

  service do
    run [opt_bin/"netscoped", "--sock", "/var/run/netscope/netscoped.sock"]
    require_root true
    keep_alive true
    log_path var/"log/netscope.log"
    error_log_path var/"log/netscope.log"
  end

  def caveats
    <<~EOS
      netscope needs a root capture daemon. Start it (admin required):
        sudo brew services start netscope

      Then run the menu-bar app (live up/down in the menu bar):
        netscope-bar
      Enable "Launch at Login" from its menu to start it automatically.

      Terminal views:
        netscope                  # live table
        netscope apps --range week

      The full dashboard window (netscope.app) ships in the GitHub release zip:
        https://github.com/doldoldol21/netscope/releases
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/netscope -h 2>&1")
    system bin/"netscoped", "-h"
  end
end
