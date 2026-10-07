# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.1/helm-ai-kernel-darwin-arm64"
      sha256 "70f4b549aedc330279883b22e4e1c34ceb5658c20891e4f45d594748adfc3de6"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.1/helm-ai-kernel-darwin-amd64"
      sha256 "75d835aa83e72ac049589b4c88c1656e0ebf3964e5bef38ad56975fe2a3fd30b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.1/helm-ai-kernel-linux-arm64"
      sha256 "ade8912b7bcf5a17ab246fbbba987b439bf737d9f36fcb6792d650b188c7130b"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.1/helm-ai-kernel-linux-amd64"
      sha256 "144e48131279316bc0369bb583ed67cf76318779e98066595f63909d07d20689"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.11.1/helm-ai-kernel-launchpad-data.tar"
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
