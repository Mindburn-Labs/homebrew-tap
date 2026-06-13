# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.11"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.11/helm-ai-kernel-darwin-arm64"
      sha256 "330895f8d8f8946b7ab602b720aea01af5e0220cf58963ca49dfc43802401beb"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.11/helm-ai-kernel-darwin-amd64"
      sha256 "2c956b05751bd22d323686bcafdb26766a7a5ddfef5f945516bbd2091b47f15e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.11/helm-ai-kernel-linux-arm64"
      sha256 "72fa8dceabffc9db86b0bfb07d51206fde4226f87b6ac131246ab45b19a06c17"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.11/helm-ai-kernel-linux-amd64"
      sha256 "deb75e35507d703e56bc192168e4a5220494e308b693997bcd0f302a85d36982"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.11/helm-ai-kernel-launchpad-data.tar"
    sha256 "36700b968c422823e936b65424aceff54f8435c34bf246e7d1d432d653176679"
  end

  def install
    binary = Dir["helm-ai-kernel-*"].first || "helm-ai-kernel"
    bin.install binary => "helm-ai-kernel"
    resource("launchpad-data").stage do
      pkgshare.install "registry"
      pkgshare.install "policies"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/helm-ai-kernel version 2>&1")
    assert_match "openclaw", shell_output("#{bin}/helm-ai-kernel launch matrix --json")
  end
end
