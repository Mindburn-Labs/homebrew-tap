# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.7.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.2/helm-ai-kernel-darwin-arm64"
      sha256 "f877331c37cca2e083bb1a297aeb2586c7580dd15b6c11c484795ea6dcc823c4"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.2/helm-ai-kernel-darwin-amd64"
      sha256 "d0d706e428bdbfce94bc271ee249a0143790ef55cdabaa89705847c4dc48c7e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.2/helm-ai-kernel-linux-arm64"
      sha256 "bcc8d3a46a63aa1ac3d3bdb74c86fc848e6831e644994e74641c881a275ad004"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.2/helm-ai-kernel-linux-amd64"
      sha256 "9d4ce7eb10b1fca8533e1c11c3c30f171cf050e3107eafd0e39e043168336a4f"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.7.2/helm-ai-kernel-launchpad-data.tar"
    sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
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
