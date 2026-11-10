# CI runs `make check` (platform-actions ci.yml@v2.0.1).
# `brew audit` only takes tap names, so the working tree is linked in as a
# throwaway tap for the audit and unlinked afterwards.
AUDIT_TAP := mindburn-labs-check/tap
AUDIT_DIR = $(shell brew --repository)/Library/Taps/mindburn-labs-check

export HOMEBREW_NO_AUTO_UPDATE := 1

check: style audit

.PHONY: check style audit

# `brew style` only applies Homebrew's Formula/ and Taps/ cop exclusions (for
# example Style/Documentation) to files inside a tap, so a checkout elsewhere,
# such as a worktree, reports offences CI never sees. Style the formulae
# through the same throwaway tap link that `audit` uses.
style:
	@mkdir -p "$(AUDIT_DIR)" && ln -sfn "$(CURDIR)" "$(AUDIT_DIR)/homebrew-tap"
	@brew style $(AUDIT_TAP); status=$$?; rm -rf "$(AUDIT_DIR)"; exit $$status

audit:
	@mkdir -p "$(AUDIT_DIR)" && ln -sfn "$(CURDIR)" "$(AUDIT_DIR)/homebrew-tap"
	@brew trust $(AUDIT_TAP) && brew audit --strict --tap=$(AUDIT_TAP); status=$$?; rm -rf "$(AUDIT_DIR)"; exit $$status
