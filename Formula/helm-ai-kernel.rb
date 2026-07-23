# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.5/helm-ai-kernel-darwin-arm64"
      sha256 "bc0e9999f02548fcd1a0f52cfadfc6c25eee0dcb7a68180c27b4341e5db59d64"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.5/helm-ai-kernel-darwin-amd64"
      sha256 "450c7e95c4ca96e9781a0403ec43e9b6e80479cf4bebd5aee9490a39396fd045"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.5/helm-ai-kernel-linux-arm64"
      sha256 "be6ff93e1537232f711902bcc51f4921d7c5bbd914702583e08f89d0293666a5"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.5/helm-ai-kernel-linux-amd64"
      sha256 "7e320b81ca5b5984dfb25d8f913c5f0d65ad73198b7be58a50b66f01898d9382"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.5/helm-ai-kernel-launchpad-data.tar"
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
