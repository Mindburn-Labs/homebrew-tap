# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.8.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.3/helm-ai-kernel-darwin-arm64"
      sha256 "e7ec46e66b1eab0e5ff5576678f1f06e1975ede49a94471eaf7a506202cd2957"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.3/helm-ai-kernel-darwin-amd64"
      sha256 "09e46e9a4a7b446e781ab5d75d446516334e5eac6aa55010b6c2ef946841f606"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.3/helm-ai-kernel-linux-arm64"
      sha256 "2d3457a8404d00c6607737fbfa027b05c866bcac006ff67f17cbd0bc07c29cd2"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.3/helm-ai-kernel-linux-amd64"
      sha256 "ed5697e872475d0d4c64b893821b12b718d0b88d7b336c26d5d6335b8dc07d64"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.3/helm-ai-kernel-launchpad-data.tar"
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
