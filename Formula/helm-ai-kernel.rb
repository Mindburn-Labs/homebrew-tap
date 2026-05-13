# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-darwin-arm64"
      sha256 "ef75326c156de77ae72407f27f7f5202973242f3a61e9aa73b974c489d39b757"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-darwin-amd64"
      sha256 "3d55077f445055e5ac9d24a468803b80f8029b0f936406bcc1848b7860b58c8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-linux-arm64"
      sha256 "02e881cb42a376094439c44e557d90d8933c0c870c302297a190e7f3c2e8d657"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.0/helm-ai-kernel-linux-amd64"
      sha256 "0bb114c5410aaf709848c214051d65573cacd8730e176905368d3409f1e3673f"
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
