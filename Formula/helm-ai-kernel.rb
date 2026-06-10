# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.10/helm-ai-kernel-darwin-arm64"
      sha256 "cc339ce7ba05c4b48fe2cd49c0575b73c092222862f54ba7af9ef62bd0545c98"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.10/helm-ai-kernel-darwin-amd64"
      sha256 "4492075bc68359c3e45ea94c27d4e452e07a936ff9bfb11819ae261d2c27b0fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.10/helm-ai-kernel-linux-arm64"
      sha256 "725d30fbd20b0bfd29fe3161385181c4c4e0d1780dd149487bc3e7604a292619"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.10/helm-ai-kernel-linux-amd64"
      sha256 "4612d14e2a211becd1062cceb6216b71cf9aa0c52e49f6a398610a420738c0fd"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.10/helm-ai-kernel-launchpad-data.tar"
    sha256 "1b60ec5d35ba0eb21db09ccd231f967aef5add49abb4d73f13683d31d54b6cd4"
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
