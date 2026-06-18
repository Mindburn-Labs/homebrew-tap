  # frozen_string_literal: true

  class HelmAiKernel < Formula
    desc "Fail-closed execution firewall for AI agents"
    homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
    version "0.5.17"
    license "Apache-2.0"

    resource "launchpad-data" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-ai-kernel-launchpad-data.tar"
      sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
    end


    resource "console-web" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-console-web-v0.5.17.tar.gz"
      sha256 "8cf0756c94bdd997833ffb94d02df4ab5cbf6c16f4ec900eb9c79761c7c92ac6"
    end


    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-ai-kernel-darwin-arm64"
        sha256 "974e67d6d380104f6c8f53f0365f28ca6760e22388e933cd3ab2c7e7e510baaf"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-ai-kernel-darwin-amd64"
        sha256 "a804cb96146c84052fb1a68f0f8f1d1e46af478e81e00132ec84d0668237bb3f"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-ai-kernel-linux-arm64"
        sha256 "0ced975606c102a43a5d0f721b0c4e8b42d5c4e507230077415b5878158e3ba8"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.17/helm-ai-kernel-linux-amd64"
        sha256 "29b56f941d600e2ffbb969cfd3f7a89002164349c9c3962dbddafaa6b55a6c34"
      end
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
