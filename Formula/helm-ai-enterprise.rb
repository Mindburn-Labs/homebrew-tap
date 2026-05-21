# typed: false
# frozen_string_literal: true

# Homebrew formula for HELM AI Enterprise.
# This is HEAD-only until the first helm-ai-enterprise GitHub release publishes
# platform binaries and SHA256SUMS.txt.

class HelmAiEnterprise < Formula
  desc "Company AI OS built on HELM AI Kernel"
  homepage "https://helm.docs.mindburn.org/helm-ai-enterprise"
  license "Apache-2.0"
  head "https://github.com/Mindburn-Labs/helm-ai-enterprise.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-o", bin/"helm-ai-enterprise", "./apps/helm-ai-enterprise"
  end

  test do
    assert_match "v", shell_output("#{bin}/helm-ai-enterprise version")
    assert_match "OK", shell_output("#{bin}/helm-ai-enterprise doctor 2>&1").lines.first
  end
end
