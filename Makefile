CHECK_TAP := mindburn-labs-check/tap
STYLE_TAP = brew style $(CHECK_TAP)
AUDIT_TAP = brew trust $(CHECK_TAP) && brew audit --strict --tap=$(CHECK_TAP)

export HOMEBREW_NO_AUTO_UPDATE := 1

.PHONY: check style audit

# Homebrew applies tap-specific style rules and audit checks to a linked checkout.
define with_check_tap
	@set -e; \
	repository=$$(brew --repository); \
	test -n "$$repository"; \
	tap_dir="$$repository/Library/Taps/mindburn-labs-check"; \
	tap_link="$$tap_dir/homebrew-tap"; \
	mkdir -p "$$repository/Library/Taps"; \
	mkdir "$$tap_dir"; \
	trap 'if [ -L "$$tap_link" ]; then unlink "$$tap_link"; fi; rmdir "$$tap_dir"' EXIT; \
	trap 'exit 1' HUP INT TERM; \
	ln -s "$(CURDIR)" "$$tap_link"; \
	$(1)
endef

check:
	$(call with_check_tap,$(STYLE_TAP) && $(AUDIT_TAP))

style:
	$(call with_check_tap,$(STYLE_TAP))

audit:
	$(call with_check_tap,$(AUDIT_TAP))
