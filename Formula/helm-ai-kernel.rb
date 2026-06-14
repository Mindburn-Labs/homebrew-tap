  # frozen_string_literal: true

  class HelmAiKernel < Formula
    desc "Fail-closed execution firewall for AI agents"
    homepage "https://github.com/Mindburn-Labs/helm-ai-kernel"
    version "0.5.14"
    license "Apache-2.0"

    resource "launchpad-data" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-ai-kernel-launchpad-data.tar"
      sha256 "38de3dbcb9d8f9b945ea120c460f0e5f3c5c98cb7930b250d1d53f38ab688967"
    end


    resource "console-web" do
      url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-console-web-v0.5.14.tar.gz"
      sha256 "6058d6025d7ddab3ae73fa5278059db81ec324ee4904941e663a8266e02a4473"
    end


    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-ai-kernel-darwin-arm64"
        sha256 "84c1e5415076fb1cd5a50aa1d66f8890142807016dd90f759da0daf5f6aeed71"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-ai-kernel-darwin-amd64"
        sha256 "1c1f6147bfa4c8ee97d2c07854be42e481ff438eadf2e71e5c70336207d74db1"
      end
    end

    on_linux do
      if Hardware::CPU.arm?
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-ai-kernel-linux-arm64"
        sha256 "8aa18560858bb63f5dde2f90d58c3414c239bbc986024a7201184b52bc5176f0"
      else
        url "https://github.com/Mindburn-Labs/helm-ai-kernel/releases/download/v0.5.14/helm-ai-kernel-linux-amd64"
        sha256 "36c870c9a5557df6dea046204460314e8dccd44421565bdeba49d190600e0845"
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
