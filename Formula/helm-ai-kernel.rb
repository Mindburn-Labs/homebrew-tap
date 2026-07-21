# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.4/helm-ai-kernel-darwin-arm64"
      sha256 "35a21ac0b7a5223c55c89e3356266ba2f23c24f8266d111813ba78f05e8b382d"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.4/helm-ai-kernel-darwin-amd64"
      sha256 "733c6e13c2086cd42f16438b187bda8b7fcc083424ef55f6e30c5763ddc3d4f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.4/helm-ai-kernel-linux-arm64"
      sha256 "19fc0fa57404777119dd45ae25674c82dc7fbe7be7dd264af1112cae10ab388e"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.4/helm-ai-kernel-linux-amd64"
      sha256 "c0fba16820c5d28c580c7efe12f56f0c79cf2e4d4eaf23f851f07ba5cd5f882e"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.4/helm-ai-kernel-launchpad-data.tar"
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
