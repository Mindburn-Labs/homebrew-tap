  # frozen_string_literal: true

  class HelmAiKernel < Formula
    desc "Fail-closed execution firewall for AI agents"
    homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
    version "0.5.13"
    license "Apache-2.0"

    resource "launchpad-data" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-ai-kernel-launchpad-data.tar"
      sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
    end


    resource "console-web" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-console-web-v0.5.13.tar.gz"
      sha256 "c6e06b1ea907eee94194a5681cdf7b158067d349e14da9e5538b9db69f996c28"
    end


    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-ai-kernel-darwin-arm64"
        sha256 "340c52cc21edaa8fe3256b2e7380c43c2a0421085f62e47c0f024580e471c1fb"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-ai-kernel-darwin-amd64"
        sha256 "2ce756555c59e261e3cf0c8c7dc6a4e6dbac51dda3dbe53591e16fd21f4c0498"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-ai-kernel-linux-arm64"
        sha256 "543c42cf90f1bdda37fa93dc7adc10c851160be1f47293913ab98dfa8289e31e"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.13/helm-ai-kernel-linux-amd64"
        sha256 "4fcaf97e9f53d54fabcd60b476823498f522cd43d3be05cab120a50e7e8bdae2"
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
