# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.5/helm-ai-kernel-darwin-arm64"
      sha256 "93de0b501b5da9a17377fff394d24e92c3adcce7fc59ceb9ef179df92afe833e"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.5/helm-ai-kernel-darwin-amd64"
      sha256 "656dfc1f28031f51f0fcea13ab913e55a8a44960bf366e03d001af76ba5a40b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.5/helm-ai-kernel-linux-arm64"
      sha256 "896dda0b67255b8e5105f28a029a2ac00634e403c897358e51dc765e97902516"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.5/helm-ai-kernel-linux-amd64"
      sha256 "3eba1463b2297b76146a59f95a38d1f0ad93b72615eabab4d5dbfd64d40c874c"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.5/helm-ai-kernel-launchpad-data.tar"
    sha256 "73504b6e55157aa69c9b362dd4151d93e88c5c6660ae26636423dafe0ffa7e89"
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
