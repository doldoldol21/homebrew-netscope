class NetscopeCli < Formula
  desc "Per-app network traffic monitor for macOS (CLI + daemon)"
  homepage "https://github.com/doldoldol21/netscope"
  url "https://github.com/doldoldol21/netscope/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "fa94415a9118c9ae5366dc5c1bf0e44c0e6a24496806cda8eb6e5ac52b67e35c"
  license "MIT"
  head "https://github.com/doldoldol21/netscope.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = "-s -w -X github.com/doldoldol21/netscope/internal/buildinfo.Version=v#{version}"
    %w[netscoped netscope].each do |cmd|
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
      Builds the netscoped daemon and the netscope CLI. Start capture (admin):
        sudo brew services start netscope-cli

      Then watch live traffic in the terminal:
        netscope
        netscope apps --range week

      For the menu-bar app + dashboard, install the app instead:
        curl -fsSL https://raw.githubusercontent.com/doldoldol21/netscope/main/install.sh | bash
    EOS
  end

  test do
    assert_path_exists bin/"netscoped"
    system bin/"netscoped", "-h"
  end
end
