# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.2/helm-ai-kernel-darwin-arm64"
      sha256 "9587548e74c631c5018374a2ecf9485af9d37b6ad861e08f93445a9a228182aa"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.2/helm-ai-kernel-darwin-amd64"
      sha256 "25433f8e7283b5a1825294018eab9311c1fb1b023a1a1da5b7c69f69a84b9bb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.2/helm-ai-kernel-linux-arm64"
      sha256 "9ee5a939424897ea1cc7a743eeac67a51c62e0ad4ffb4ed0be4b2161e3b3affe"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.2/helm-ai-kernel-linux-amd64"
      sha256 "b7c41feeca22aace7f3f4c10a1094b9195694f29fb6cf7a89066ac6c5a599973"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.2/helm-ai-kernel-launchpad-data.tar"
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
