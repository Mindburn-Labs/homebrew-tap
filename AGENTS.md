# Agent Operational Guidelines for homebrew-tap

Homebrew tap for the HELM CLIs: `Formula/helm-ai-kernel.rb` (pinned release
binaries) and `Formula/helm-ai-enterprise.rb` (HEAD-only source build).

## Dev Commands
* Lint formulae: `brew audit --strict --tap mindburn-labs/tap`
* Install and test: `brew install --build-from-source mindburn-labs/tap/helm-ai-kernel`,
  then `brew test helm-ai-kernel`
* CI runs `brew test-bot` (`tests.yml`). The `make` targets only echo
  placeholders.
* A `helm-ai-kernel` bump updates `version`, every release URL, and every
  `sha256` together.

## Safety & Geofence Boundaries
* Zero active static keys committed in this repository.
* The `pr-pull` label triggers `publish.yml`, which publishes bottles and pushes
  to `main`. That is a package publish: add it under the `helm-privileged-ops`
  procedure (pinned formula SHA, then read back the bottles and the `main`
  push).
