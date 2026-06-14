  # frozen_string_literal: true

  class HelmAiKernel < Formula
    desc "Fail-closed execution firewall for AI agents"
    homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
    version "0.5.15"
    license "Apache-2.0"

    resource "launchpad-data" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-ai-kernel-launchpad-data.tar"
      sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
    end


    resource "console-web" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-console-web-v0.5.15.tar.gz"
      sha256 "a8ddf0cc7bc4d1a42b0bdb71e80f77b34ddab0702f9c9326e4ccc78d8cfe8f74"
    end


    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-ai-kernel-darwin-arm64"
        sha256 "c8e51d012d3888e273f2491b661e78b8bb191fab1bc2a96ced897fdcea4fd0ec"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-ai-kernel-darwin-amd64"
        sha256 "79867ae228a31a57c557007f8ff9d9be8d3102f710a0408a8b810e125110141c"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-ai-kernel-linux-arm64"
        sha256 "ce08968a3c75fe15a249f6b0d156e0721f9eb48ddef79959d5a28d63bcae2a6d"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.15/helm-ai-kernel-linux-amd64"
        sha256 "26fcf3efd9722c61e6aa5f807503e0480ccbf27853be2b41199755e0b44c5a57"
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
