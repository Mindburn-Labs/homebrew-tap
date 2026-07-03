# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.6.0/helm-ai-kernel-darwin-arm64"
      sha256 "25a8e34b9e0378c3dec72286a9eebeeff99487d890639886d6e926f62772db9e"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.6.0/helm-ai-kernel-darwin-amd64"
      sha256 "2ccc442dd26279a0c54de62d4170d40b8e2f9735bcc0070da5fe16c3d10b9ffa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.6.0/helm-ai-kernel-linux-arm64"
      sha256 "40526fbf3c50463dbff04e736f5651373e5345758330b12b1b2c452c259ced79"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.6.0/helm-ai-kernel-linux-amd64"
      sha256 "f9053b8c29475f31d66723a01ed8a1322e623766222838c4585c1c2c18167385"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.6.0/helm-ai-kernel-launchpad-data.tar"
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
