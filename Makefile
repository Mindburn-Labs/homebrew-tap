# CI runs `make check` (platform-actions ci.yml v2, local public copy ci-v2.yml).
# `brew audit` only takes tap names, so the working tree is linked in as a
# throwaway tap for the audit and unlinked afterwards.
AUDIT_TAP := mindburn-labs-check/tap
AUDIT_DIR = $(shell brew --repository)/Library/Taps/mindburn-labs-check

export HOMEBREW_NO_AUTO_UPDATE := 1

check: style audit

.PHONY: check style audit

style:
	brew style Formula/*.rb

audit:
	@mkdir -p "$(AUDIT_DIR)" && ln -sfn "$(CURDIR)" "$(AUDIT_DIR)/homebrew-tap"
	@brew audit --strict --tap=$(AUDIT_TAP); status=$$?; rm -rf "$(AUDIT_DIR)"; exit $$status
