# Runbook: homebrew-tap

This repository holds Homebrew formulae and runs no service. A formula change
reaches users when it lands on `main` and they run `brew update`.

## Release Verification
Pull requests run `brew test-bot` (`tests.yml`) and `make check`
(`brew style` and `brew audit --strict`, required as `ci / gate`). After a
`helm-ai-kernel` bump merges, check the published formula:

```bash
brew trust --formula mindburn-labs/tap/helm-ai-kernel
brew update
brew upgrade mindburn-labs/tap/helm-ai-kernel
brew test helm-ai-kernel      # the formula's test block
helm-ai-kernel version        # prints the new version
```

## Recovery Procedures
Revert the bad formula commit on `main` through a pull request. The revert
restores the previous release URLs, checksums, resources, and test block.
Machines that installed the bad version can run `brew update` and
`brew reinstall mindburn-labs/tap/helm-ai-kernel`.
