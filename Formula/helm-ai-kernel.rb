# frozen_string_literal: true

class HelmAiKernel < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.4/helm-ai-kernel-darwin-arm64"
      sha256 "460e6e0e5a92aed03849e075507b1f154229a7eecc94c4ca629dec128c55e32e"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.4/helm-ai-kernel-darwin-amd64"
      sha256 "c0fb0c108c2800f6dc70957a887b4297f5d82a42e4960d170da1ca1679cd0ee6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.4/helm-ai-kernel-linux-arm64"
      sha256 "059c437fc139352ee2081671bed50d08beae73f0e1ab845936d630bb851b9acd"
    else
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.4/helm-ai-kernel-linux-amd64"
      sha256 "4424d4090da4fc94d18f0a7fd398e14ea9cda920e0bd2b19ecb686493af4a673"
    end
  end

  resource "launchpad-data" do
    url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.8.4/helm-ai-kernel-launchpad-data.tar"
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
