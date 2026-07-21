# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.3/helm-ai-kernel-darwin-arm64"
      sha256 "25cd095fe4b77cf0b49d6e66af36c67523f80ae806cb56b6f0e2bf5cdd6d51ef"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.3/helm-ai-kernel-darwin-amd64"
      sha256 "5d7560ac38c3a277cf0ae58f7bb0375d3c42bebe40f7c2e9250990a36ddd89de"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.3/helm-ai-kernel-linux-arm64"
      sha256 "877e4aedec0dac5daff8ecb8d4342e4fe79b5a1d1af613b1979cc87f0af2b378"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.3/helm-ai-kernel-linux-amd64"
      sha256 "b57171e8b9350a6f2e16ad56eba3fb36a87967dc4041891d516c0a62282d0e6a"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.3/helm-ai-kernel-launchpad-data.tar"
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
