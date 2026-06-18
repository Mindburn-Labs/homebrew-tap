  # frozen_string_literal: true

  class HelmAiKernel < Formula
    desc "Fail-closed execution firewall for AI agents"
    homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
    version "0.5.16"
    license "Apache-2.0"

    resource "launchpad-data" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-ai-kernel-launchpad-data.tar"
      sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
    end


    resource "console-web" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-console-web-v0.5.16.tar.gz"
      sha256 "3c6a76deab493a120ec9b362f5759babb9150317b15e5db6879975ecc8af6caf"
    end


    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-ai-kernel-darwin-arm64"
        sha256 "8dbf4768cea9816f89625b79abeb9a4f287ae7caebe237cc095b3744ae49d67a"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-ai-kernel-darwin-amd64"
        sha256 "27ded3ac49638dc674cd939cbaff512ebf092b2af046964d24a0f9a4513a54e9"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-ai-kernel-linux-arm64"
        sha256 "58f4b99c4324f0369cf8a1e7c37922e0b03b8c3aeffa56d03dc3de1abe766488"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.16/helm-ai-kernel-linux-amd64"
        sha256 "c43236e55e08b4d14fdcb127896536913b2020e7d9255145fe2eb171ea3778ff"
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
