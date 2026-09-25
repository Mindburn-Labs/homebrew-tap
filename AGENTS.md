# Agent Operational Guidelines for homebrew-tap

Homebrew tap for the HELM CLIs: `Formula/helm-ai-kernel.rb` (pinned release
binaries) and `Formula/helm-ai-enterprise.rb` (HEAD-only source build).

## Dev Commands
* Lint formulae: `brew audit --strict --tap mindburn-labs/tap`
* Install and test: `brew install --build-from-source mindburn-labs/tap/helm-ai-kernel`,
  then `brew test helm-ai-kernel`
* `make check` runs `brew style` and `brew audit --strict` on the formulae;
  CI runs it (`ci.yml`). `tests.yml` also runs `brew test-bot` (tap syntax,
  install and test on macOS and Linux).
* A `helm-ai-kernel` bump updates `version`, every release URL, and every
  `sha256` together.

## Safety & Geofence Boundaries
* Zero active static keys committed in this repository.
* Formula PRs merge on a green `ci / gate`; there is no `pr-pull` label step and
  no bottle publish (the formulae install prebuilt release binaries or build
  from HEAD). A formula change reaches users once it lands on `main`.
