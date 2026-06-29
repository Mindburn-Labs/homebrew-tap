# homebrew-tap

Homebrew tap for [Mindburn Labs](https://mindburn.org) HELM command-line tools.
Provides formulae to install the HELM AI Kernel and HELM AI Enterprise binaries
via `brew`.

HELM is a fail-closed execution firewall for AI agents.

## Install

```bash
brew tap Mindburn-Labs/tap
brew install helm-ai-kernel
```

`brew tap Mindburn-Labs/tap` adds this repository (`Mindburn-Labs/homebrew-tap`)
as a tap; the formulae then resolve as `Mindburn-Labs/tap/<formula>`.

### Formulae

| Formula | Source repo | Install kind |
| --- | --- | --- |
| `helm-ai-kernel` | [`Mindburn-Labs/helm-ai-kernel`](https://github.com/Mindburn-Labs/helm-ai-kernel) | Versioned — downloads the prebuilt release binary for your platform (macOS/Linux, arm64/amd64) |
| `helm-ai-enterprise` | [`Mindburn-Labs/helm-ai-enterprise`](https://github.com/Mindburn-Labs/helm-ai-enterprise) | HEAD-only — builds from source with the Go toolchain (`go build ./apps/helm-ai-enterprise`) |

```bash
# HELM AI Kernel (open source, Apache-2.0)
brew install helm-ai-kernel
helm-ai-kernel version

# HELM AI Enterprise (builds the latest main branch from source)
brew install --HEAD helm-ai-enterprise
```

`helm-ai-enterprise` is HEAD-only until the first `helm-ai-enterprise` GitHub
release publishes platform binaries and `SHA256SUMS.txt`; it requires a Go build
toolchain (`brew install go`, declared as a build dependency).

## Repository layout

```text
.
├── Formula/                  # Homebrew formulae
│   ├── helm-ai-kernel.rb      # versioned release-binary formula
│   └── helm-ai-enterprise.rb  # HEAD-only source-build formula
├── .github/workflows/        # CI: test-bot, pr-pull, agent gates
│   ├── tests.yml              # brew test-bot (tap syntax, formulae, bottles)
│   ├── publish.yml            # brew pr-pull (merge bottles on the pr-pull label)
│   └── ci.yml                 # agent.yaml contract + repository gates
├── docs/                     # runbook + ADRs
├── observability/            # alert rule definitions
├── Makefile                  # repo gate targets (setup/test/lint/build)
├── agent.yaml                # agent contract (repo type, owners, commands)
├── AGENTS.md                 # agent operational guidelines
├── CODEOWNERS                # ownership
├── SECURITY.md               # vulnerability disclosure
└── renovate.json             # dependency update config
```

## Formula maintenance

### Updating `helm-ai-kernel`

`Formula/helm-ai-kernel.rb` pins a `version` and four release-binary `url` +
`sha256` pairs (macOS/Linux × arm64/amd64), plus a `launchpad-data` resource.
To bump it for a new `helm-ai-kernel` release, update the `version`, the release
download URLs, and each `sha256` to match the published release artifacts.

### CI and bottle publishing

- **`tests.yml`** runs `brew test-bot` on every push and pull request across
  `macos-15-intel`, `macos-26`, and the `ghcr.io/homebrew/brew:main` Ubuntu
  container. It runs `--only-tap-syntax` and `--only-formulae`, and uploads the
  built bottles as artifacts. A PR that touches **only**
  `Formula/helm-ai-enterprise.rb` skips the `brew install` step, because that
  formula is HEAD-only.
- **`publish.yml`** runs `brew pr-pull` when a maintainer adds the `pr-pull`
  label to a PR. It pulls the bottle artifacts, pushes the resulting commits to
  `main`, and deletes the PR branch (for non-fork PRs).
- **`ci.yml`** validates `agent.yaml` against its canonical keys, enforces that
  `.codegraph/` is never committed, and runs the available `make` gate targets
  (`setup`, `lint`, `test`, `build`).

### Local validation

```bash
brew tap Mindburn-Labs/tap
brew audit --strict --tap Mindburn-Labs/tap   # lint the formulae
brew install --build-from-source helm-ai-kernel
brew test helm-ai-kernel                      # run the formula's test block
```

## Security

Report vulnerabilities per [SECURITY.md](SECURITY.md)
(`security@mindburn.org`); do not open public issues.

## License

`helm-ai-kernel` and `helm-ai-enterprise` are distributed under Apache-2.0; see
each formula and its upstream repository. This tap repository contains only the
formulae and CI that package those tools.
