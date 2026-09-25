# Runbook: homebrew-tap

This repository holds Homebrew formulae and runs no service. A formula change
reaches users when it lands on `main` and they run `brew update`.

## Release Verification
Pull requests run `brew test-bot` (`tests.yml`) and `make check`
(`brew style` and `brew audit --strict`, required as `ci / gate`). After a
`helm-ai-kernel` bump merges, check the published formula:

```bash
brew update
brew upgrade mindburn-labs/tap/helm-ai-kernel
brew test helm-ai-kernel      # the formula's test block
helm-ai-kernel version        # prints the new version
```

## Recovery Procedures
Revert the bad formula commit on `main` through a pull request. For a
`helm-ai-kernel` bump the revert restores the previous `version`, release URLs
and `sha256` values together. Machines that already installed the bad version
get the reverted formula with `brew update` and
`brew reinstall mindburn-labs/tap/helm-ai-kernel`.
