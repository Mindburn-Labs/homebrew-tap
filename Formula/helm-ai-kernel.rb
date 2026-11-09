# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.12.0/helm-ai-kernel-darwin-arm64"
      sha256 "13d2bdbfce350650a374278523b4ba865724568827ca5db295f9f001bc984a9d"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.12.0/helm-ai-kernel-darwin-amd64"
      sha256 "f1bf406240c6432db3ac8027a1fe873e4d4aa3fa64b4ecb4203d58141ef9fd18"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.12.0/helm-ai-kernel-linux-arm64"
      sha256 "9150e48049ed068fb9490ab7498a143855a531511a4cdf872165512548e8d180"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.12.0/helm-ai-kernel-linux-amd64"
      sha256 "4ad428ad2f62f1d25364221c6c7e08fa96bf47be5fd0f535484ab3f56a37d1fc"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.12.0/helm-ai-kernel-launchpad-data.tar"
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
