# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.4/helm-ai-kernel-darwin-arm64"
      sha256 "860921cea3538fb6f6e1bb66dd905070f415b91834b75c7c4fc2f768b197c592"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.4/helm-ai-kernel-darwin-amd64"
      sha256 "e6688d171f7068e276d477e63ec5b26e2c171d1c33fcb6aae9ae3f76cbf15542"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.4/helm-ai-kernel-linux-arm64"
      sha256 "3c9e3d7736c2a9ea3cb0f694164c50f5f68d7916085a88053ed35c4362909d73"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.4/helm-ai-kernel-linux-amd64"
      sha256 "2fbed7a3e08bee70ca0ee1854a332d79634503d6d5ce45890989e85745281817"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.4/helm-ai-kernel-launchpad-data.tar"
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
