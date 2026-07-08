# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.1/helm-ai-kernel-darwin-arm64"
      sha256 "f034c359d2bc19c76b027be4f80cc54ace99ae0076f5326fc7f828ca60e181f7"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.1/helm-ai-kernel-darwin-amd64"
      sha256 "c2ae5c01db9f4786f667c0760776b7f33fe29c84ca6d96c690297468d13af16c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.1/helm-ai-kernel-linux-arm64"
      sha256 "0c90e77dd13f6351ddba706f4f16755941a145f0b8b718e208d7b43c97dcb237"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.1/helm-ai-kernel-linux-amd64"
      sha256 "03eaf90e2d4bfac6ff9ef60d839edbc1a1efc482c6320d4ef35661e412ba93e8"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.1/helm-ai-kernel-launchpad-data.tar"
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
