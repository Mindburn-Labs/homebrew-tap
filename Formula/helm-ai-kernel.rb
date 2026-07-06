# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.0/helm-ai-kernel-darwin-arm64"
      sha256 "c55accdc098899ab7a587d488d588e13950b73c9ad1f9872544a689661a56600"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.0/helm-ai-kernel-darwin-amd64"
      sha256 "449f5122d1f16abd3c4e75a44ac3748d024a7d4c09f58c8a24d54c0e488cf6a2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.0/helm-ai-kernel-linux-arm64"
      sha256 "405b385b2cf44d95131efe75da188ff9f5e589bfed80b131f83892137dd8d642"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.0/helm-ai-kernel-linux-amd64"
      sha256 "e5f1f7b94e16235bb87c0ab3701613cf0b4fd08fea97c5a33b7a8db6a905fda4"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.0/helm-ai-kernel-launchpad-data.tar"
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
