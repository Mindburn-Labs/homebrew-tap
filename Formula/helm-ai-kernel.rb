# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.10.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.0/helm-ai-kernel-darwin-arm64"
      sha256 "4ca7f5c231e80e319f963c157144e15a9204229b76abfe14332a9cf1fd3675ee"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.0/helm-ai-kernel-darwin-amd64"
      sha256 "f5e6fbd7c52bc7c92166c42a06bb63cadaf8e0a2d54217e1af0a7481ac7760a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.0/helm-ai-kernel-linux-arm64"
      sha256 "2f28741cfa0958ffca7911be1cbba70d2fe39a2227d989a3334c739c5546d3b7"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.0/helm-ai-kernel-linux-amd64"
      sha256 "a8e363f109bd51d2bb4ab2437f99d44b6b938bdecb17b4461a607a3589eb5489"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.10.0/helm-ai-kernel-launchpad-data.tar"
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
