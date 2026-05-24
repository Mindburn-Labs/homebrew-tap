# Mindburn Labs Homebrew Tap

Formulae for Mindburn Labs command-line tools.

## Canonical Tap

`Mindburn-Labs/homebrew-tap` is the canonical Homebrew tap for Mindburn Labs
formulae. The legacy lowercase `mindburnlabs/homebrew-tap` mirror should not be
used for new install instructions or release announcements.

## Install HELM AI Kernel

```sh
brew install Mindburn-Labs/homebrew-tap/helm-ai-kernel
```

Verify the install:

```sh
helm-ai-kernel version
helm-ai-kernel launch matrix --json
```

## Install HELM AI Enterprise

HELM AI Enterprise is staged as a HEAD-only formula until
`Mindburn-Labs/helm-ai-enterprise` publishes its first release binaries and
`SHA256SUMS.txt`.

```sh
brew install --HEAD Mindburn-Labs/homebrew-tap/helm-ai-enterprise
```

Verify the install:

```sh
helm-ai-enterprise version
helm-ai-enterprise doctor
```

## Legacy Tap Migration

If you previously installed from the lowercase legacy tap, switch with:

```sh
brew uninstall mindburnlabs/tap/helm-ai-kernel
brew untap mindburnlabs/tap
brew install Mindburn-Labs/homebrew-tap/helm-ai-kernel
```

HELM AI Enterprise source and release planning live at:

https://github.com/Mindburn-Labs/helm-ai-enterprise
