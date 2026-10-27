# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.3/helm-ai-kernel-darwin-arm64"
      sha256 "5d2a11068a0df11f12b88656f67fb3fc881faf044990542e8ced5bfa3f8466b8"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.3/helm-ai-kernel-darwin-amd64"
      sha256 "bd8a89bbbceda8abe068e821e1239ad23326443641bc50138bbdd80d1f101074"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.3/helm-ai-kernel-linux-arm64"
      sha256 "238438d28f8b640db935fe745175830896a03512c0dd818c2c4be0a3df32c2c9"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.3/helm-ai-kernel-linux-amd64"
      sha256 "c11f50be027d47acc56f740369f3934d16afed528b3a960929f167e7b660d398"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.3/helm-ai-kernel-launchpad-data.tar"
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
