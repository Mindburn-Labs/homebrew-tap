# Mindburn Labs Homebrew Tap

Formulae for Mindburn Labs command-line tools.

## Install HELM OSS

The canonical tap for HELM OSS has moved.

Please use the public `mindburnlabs` organization tap:

```sh
brew install mindburnlabs/tap/helm
```

If you previously installed from this legacy tap, please switch:

```sh
brew uninstall Mindburn-Labs/homebrew-tap/helm
brew untap Mindburn-Labs/homebrew-tap
brew install mindburnlabs/tap/helm
```

Then run:

```sh
helm serve --policy ./release.high_risk.v3.toml
```

This installs the HELM OSS boundary CLI from release binaries published at:

https://github.com/Mindburn-Labs/helm-oss/releases
