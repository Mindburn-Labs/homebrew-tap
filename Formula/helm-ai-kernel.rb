# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.5.18"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-ai-kernel-darwin-arm64"
      sha256 "5fcd46d1fb6e6998164d7b3bbcce7c7461d78889a9336dbec3e5effb0df7e163"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-ai-kernel-darwin-amd64"
      sha256 "9fff4b56bc78f9228c5f4ebdb4a57e91765b0817763e35addddb4e6e9b9adc46"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-ai-kernel-linux-arm64"
      sha256 "c9792403223189d95a6fd66d585ac7c36ae118aa4d6954771c8857ed8da94200"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-ai-kernel-linux-amd64"
      sha256 "a0e9ee2ebb6bb01fb190ab4cb901117f3fc71c9204a155a4f1c4f63adced20ff"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-ai-kernel-launchpad-data.tar"
    sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
  end

  resource "console-web" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.18/helm-console-web-v0.5.18.tar.gz"
    sha256 "791aa544500d387c38de37e627b22782d542b7323226aced156041bd2e37fce4"
  end

  def install
    binary = Dir["helm-ai-kernel-*"].first || "helm-ai-kernel"
    bin.install binary => "helm-ai-kernel"
    resource("launchpad-data").stage do
      pkgshare.install "registry"
      pkgshare.install "policies"
    end

    resource("console-web").stage do
      (pkgshare/"console").install Dir["*"]
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/helm-ai-kernel version 2>&1")
    assert_match "openclaw", shell_output("#{bin}/helm-ai-kernel launch matrix --json")
    assert_path_exists pkgshare/"console/index.html" if resources.map(&:name).include?("console-web")
  end
end
