# homebrew-tap

Homebrew tap for [Mindburn Labs](https://mindburn.org) HELM command-line tools.
Provides formulae to install the HELM AI Kernel and HELM AI Enterprise binaries
via `brew`.

HELM is a fail-closed execution firewall for AI agents.

## Install

```bash
brew tap mindburn-labs/tap
brew install mindburn-labs/tap/helm-ai-kernel
```

`brew tap mindburn-labs/tap` adds this repository (`Mindburn-Labs/homebrew-tap`)
as a tap; the formulae then resolve as `mindburn-labs/tap/<formula>`.

### Formulae

| Formula | Source repo | Install kind |
| --- | --- | --- |
| `helm-ai-kernel` | [`Mindburn-Labs/helm-ai-kernel`](https://github.com/Mindburn-Labs/helm-ai-kernel) | Versioned — downloads the prebuilt release binary for your platform (macOS/Linux, arm64/amd64) |
| `helm-ai-enterprise` | [`Mindburn-Labs/helm-ai-enterprise`](https://github.com/Mindburn-Labs/helm-ai-enterprise) | HEAD-only — builds from source with the Go toolchain (`go build ./apps/helm-ai-enterprise`) |

```bash
# HELM AI Kernel (open source, Apache-2.0)
brew install mindburn-labs/tap/helm-ai-kernel
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
├── .github/workflows/        # CI: test-bot and the CI v2 gate
│   ├── tests.yml              # brew test-bot (tap syntax, formulae, bottles)
│   ├── ci.yml                 # CI v2 caller: make check (brew style + audit)
│   └── ci-v2.yml              # public copy of platform-actions ci.yml@v2
├── docs/                     # runbook + ADRs
├── observability/            # alert rule definitions
├── Makefile                  # make check: brew style + brew audit --strict
├── agent.yaml                # agent contract (repo type, owners, commands)
├── AGENTS.md                 # agent operational guidelines
├── CODEOWNERS                # ownership
└── SECURITY.md               # vulnerability disclosure
```

## Formula maintenance

### Updating `helm-ai-kernel`

`Formula/helm-ai-kernel.rb` pins a `version` and four release-binary `url` +
`sha256` pairs (macOS/Linux × arm64/amd64), plus a `launchpad-data` resource.
To bump it for a new `helm-ai-kernel` release, update the `version`, the release
download URLs, and each `sha256` to match the published release artifacts.

### CI and merging

- **`tests.yml`** runs `brew test-bot` on every push and pull request across
  `macos-15-intel`, `macos-26`, and the `ghcr.io/homebrew/brew:main` Ubuntu
  container. It runs `--only-tap-syntax` and `--only-formulae`, and uploads the
  built bottles as artifacts. A PR that touches **only**
  `Formula/helm-ai-enterprise.rb` skips the `brew install` step, because that
  formula is HEAD-only.
- **`ci.yml`** calls `ci-v2.yml`, a byte-for-byte copy of
  `platform-actions` `ci.yml@v2` (a public repository cannot call the internal
  one). It runs `make check` (`brew style` and `brew audit --strict` on the
  formulae) and a dependency scan; `ci / gate` is the required check.

Formula PRs merge on a green `ci / gate`; there is no label step. The tap
publishes no bottles: `helm-ai-kernel` installs prebuilt release binaries and
`helm-ai-enterprise` builds from HEAD, so a formula change reaches users as soon
as it lands on `main`.

### Local validation

```bash
brew tap mindburn-labs/tap
brew audit --strict --tap mindburn-labs/tap   # lint the formulae
brew install --build-from-source mindburn-labs/tap/helm-ai-kernel
brew test helm-ai-kernel                      # run the formula's test block
```

## Security

Report vulnerabilities per [SECURITY.md](SECURITY.md)
(`security@mindburn.org`); do not open public issues.

## License

`helm-ai-kernel` and `helm-ai-enterprise` are distributed under Apache-2.0; see
each formula and its upstream repository. This tap repository contains only the
formulae and CI that package those tools.
