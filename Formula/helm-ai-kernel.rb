# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.3/helm-ai-kernel-darwin-arm64"
      sha256 "5fb3110e2cf1622e9a412e0609a8aaa2bb67a3324469f0ddf3834e97f0ed6aeb"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.3/helm-ai-kernel-darwin-amd64"
      sha256 "c4daf1e8247c6df4d31de133e662711b02c48cdd2cd518c54950cea3d782e205"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.3/helm-ai-kernel-linux-arm64"
      sha256 "711ddae2d02cbcda9ebe338791deaa9ba89b598e655e6527c2d539cec25da500"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.3/helm-ai-kernel-linux-amd64"
      sha256 "84fafcca58e2147e711030d59d19b904aa2d34f01d816bde1eb4ad80305ff48f"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.3/helm-ai-kernel-launchpad-data.tar"
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
