# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.6/helm-ai-kernel-darwin-arm64"
      sha256 "497ae1e251af0364cd0453c8da8706ffcc918291ba666eeaad46677757a72647"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.6/helm-ai-kernel-darwin-amd64"
      sha256 "9c0ae72db94cb84aa35472bcb5f601945cd4038267ddb48772df71751224833a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.6/helm-ai-kernel-linux-arm64"
      sha256 "13d5503e42f8ff53499426076c74e3470c9934c436338e25f41296e3cde9d6ed"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.6/helm-ai-kernel-linux-amd64"
      sha256 "7b76d563e2a9cfb1e8331ee6f1f8fdb2ac14f273ee062360d8ef267467d9a892"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.6/helm-ai-kernel-launchpad-data.tar"
    sha256 "603c4d85d1d87a0b154a7265860bb5da97fb4c9446b1aad7cf0a0a7c8ad5aee4"
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
