# Mindburn Labs Homebrew tap

Install the open-source [HELM AI Kernel](https://github.com/Mindburn-Labs/helm-ai-kernel)
on macOS or Linux. Homebrew downloads the release binary for your ARM64 or
x86-64 machine.

```sh
brew install mindburn-labs/tap/helm-ai-kernel
helm-ai-kernel version
```

The fully qualified command adds this tap and grants trust to this formula.
For an existing tap that requires formula trust before upgrading, run
`brew trust --formula mindburn-labs/tap/helm-ai-kernel`. See
[Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust).

## Enterprise source build

If you can clone the private
[HELM AI Enterprise repository](https://github.com/Mindburn-Labs/helm-ai-enterprise),
use the HEAD formula to build its `main` branch. Homebrew installs Go as a
build dependency.

```sh
brew install --HEAD mindburn-labs/tap/helm-ai-enterprise
```

## Maintain the tap

When updating [`helm-ai-kernel`](Formula/helm-ai-kernel.rb), use one published
release for the four platform binaries and the `launchpad-data` archive.
Update every URL and its SHA-256 together.

Run `make check` with Homebrew installed. The [required CI gate](.github/workflows/ci.yml)
runs style and strict formula audit. On pull requests, [Homebrew test-bot](.github/workflows/tests.yml)
checks tap syntax and tests installable formula changes on macOS and Linux.
Enterprise-only formula changes get the syntax check because the source is private.

See the [runbook](docs/runbook.md) to verify a formula update or revert a bad one.
Report vulnerabilities through the [security policy](SECURITY.md).
