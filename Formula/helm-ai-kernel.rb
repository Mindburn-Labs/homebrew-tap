# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.0/helm-ai-kernel-darwin-arm64"
      sha256 "c2b151b2d64139b1fd6835250becdaedc6ea8d8c35ba3b00f412de3a6cec8dd8"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.0/helm-ai-kernel-darwin-amd64"
      sha256 "ba98b406e25b849103646ac95f74b6195d2434a9a7b4ba5f0d1e214d7d07076b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.0/helm-ai-kernel-linux-arm64"
      sha256 "08443104474a22b2f6accbfeecce40ee93929ee17a819887a26f01940b328310"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.0/helm-ai-kernel-linux-amd64"
      sha256 "e869674d973c555b56fa6b0229c93cb61eea96bbbd6e1505c5ae8f8eb4de62ea"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.0/helm-ai-kernel-launchpad-data.tar"
    sha256 "de9c22c7eb0f0c69dd2c949caa5ac7ffde4a6df917866292552d721c277e2972"
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
