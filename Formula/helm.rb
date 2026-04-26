# frozen_string_literal: true

class Helm < Formula
  desc "Fail-closed execution firewall for AI agents"
  homepage "https://github.com/Mindburn-Labs/helm-oss"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-oss/releases/download/v0.4.0/helm-darwin-arm64"
      sha256 "24ea86a97967a6ab66ce2bee5b1f4c3b0aa47a0c87c1e4ae99af46234e7e0271"
    else
      url "https://github.com/Mindburn-Labs/helm-oss/releases/download/v0.4.0/helm-darwin-amd64"
      sha256 "3b895fd4220879146676fed8ffb3760e66e34fcad95ae1924347435feab88ab6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Mindburn-Labs/helm-oss/releases/download/v0.4.0/helm-linux-arm64"
      sha256 "a88796fe449b2d922bc5337bd1e0cce72d26af1762b32baaa8e1dcceaaebb898"
    else
      url "https://github.com/Mindburn-Labs/helm-oss/releases/download/v0.4.0/helm-linux-amd64"
      sha256 "647117824825416b4d1e527621fdf0340d7cc88a13254a260b6f6dc6a8ff2841"
    end
  end

  def install
    binary = Dir["helm-*"].first || "helm"
    bin.install binary => "helm"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/helm version 2>&1")
  end
end
