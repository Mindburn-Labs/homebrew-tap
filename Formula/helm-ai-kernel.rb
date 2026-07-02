# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.20"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.20/helm-ai-kernel-darwin-arm64"
      sha256 "6f9e979beed73feb03c76db487dc0f7223d86b0f8d9a5938ead75b3c8e736f78"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.20/helm-ai-kernel-darwin-amd64"
      sha256 "3aa223bbbe64d64f0ef29c3c8fdc5d22008a317396265982213ba2ec2efd1b41"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.20/helm-ai-kernel-linux-arm64"
      sha256 "164bf2b8eb05e122a25d2263fa11fb7bdf4dd21d8a83dc00b6b2e771c0c5fc1e"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.20/helm-ai-kernel-linux-amd64"
      sha256 "27da325d6b328534db058c9b894d48e32485904a191e2b0faf7f1600735021c2"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.20/helm-ai-kernel-launchpad-data.tar"
    sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
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
