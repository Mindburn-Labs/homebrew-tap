# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-darwin-arm64"
      sha256 "e0ffd2ca32bf4cf4ad0ef67bcf3b457743113ac9c27b7e4645f26bd31ce0328c"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-darwin-amd64"
      sha256 "49a79a0a652331182103b65dbc98eaf464b3ca3b10a4daf188a66b1e4a8519ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-linux-arm64"
      sha256 "3c754e13d4503d9635ce1f5022733487947abb807bb8e46a994444599f756d3d"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-linux-amd64"
      sha256 "f4bf73a452e46ee16b2a06041f6eacaa2afddb547add861c1b935edb72314108"
    end
  end

  def install
    binary = Dir["helm-ai-kernel-*"].first || "helm-ai-kernel"
    bin.install binary => "helm-ai-kernel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/helm-ai-kernel version 2>&1")
  end
end
