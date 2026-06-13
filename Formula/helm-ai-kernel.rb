# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.12"
  license "Apache-2.0"

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.12/helm-ai-kernel-launchpad-data.tar"
    sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.12/helm-ai-kernel-darwin-arm64"
      sha256 "86d13ee6d1efe6e38422cc7f132fc9ed0e9dba6789bb0037ece26f707883d9df"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.12/helm-ai-kernel-darwin-amd64"
      sha256 "bb78650dbed7f18340e5e941befee9f7f974f18f9d19bbb335516e047a05be01"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.12/helm-ai-kernel-linux-arm64"
      sha256 "059e76db1c5dc01fc04f4e562888a60c7eded723f9ec4003129ae7c0fc0cb255"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.12/helm-ai-kernel-linux-amd64"
      sha256 "c6e8515830c5456291457d51cb10615f47fe475c15f0f3df5ab42f173e5c6899"
    end
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
