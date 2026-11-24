# Agent Operational Guidelines for homebrew-tap

<!-- helm-sdlc-baseline:v1 -->
Apply the [HELM SDLC baseline](https://github.com/Mindburn-Labs/docs/blob/main/ai/sdlc.md).
Before implementation, define the outcome and observable acceptance conditions.
Use the existing tracker and isolated worktree; verify in proportion to risk with
the owning repository's checks. Bind results to the tested source and configuration.
Missing, skipped or inconclusive required checks are not passes. Report source,
CI, release, deployment, runtime and user acceptance separately; verify applicable
rollback, restoration and external-effect recovery. Use `Refs` while acceptance
work remains and `Closes` only when the whole issue is fulfilled. Preserve existing
authority boundaries and never bypass failed checks or move published tags.
<!-- /helm-sdlc-baseline -->

Homebrew tap for the HELM CLIs: `Formula/helm-ai-kernel.rb` (pinned release
binaries) and `Formula/helm-ai-enterprise.rb` (HEAD-only source build).

## Dev Commands
* Lint formulae: `brew audit --strict --tap mindburn-labs/tap`
* Install and test: `brew install mindburn-labs/tap/helm-ai-kernel`,
  then `brew test helm-ai-kernel`
* `make check` runs `brew style` and `brew audit --strict` on the formulae;
  CI runs it (`ci.yml`). `tests.yml` also runs `brew test-bot` (tap syntax,
  install and test on macOS and Linux).
* A `helm-ai-kernel` bump updates every release URL and checksum together.
  Keep resources and tests aligned with the pinned release.

## Release checks
* Zero active static keys committed in this repository.
* Formula PRs merge on a green `ci / gate`; there is no `pr-pull` label step and
  no bottle publish (the formulae install prebuilt release binaries or build
  from HEAD). A formula change reaches users once it lands on `main`.
