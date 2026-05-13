# Mindburn Labs Homebrew Tap

Formulae for Mindburn Labs command-line tools.

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

## Legacy HELM OSS Formula

`Formula/helm.rb` is preserved for existing users of the legacy OSS formula.
The canonical public OSS tap has moved to the `mindburnlabs` organization tap:

```sh
brew install mindburnlabs/tap/helm
```

If you previously installed from this legacy tap, switch with:

```sh
brew uninstall Mindburn-Labs/homebrew-tap/helm
brew untap Mindburn-Labs/homebrew-tap
brew install mindburnlabs/tap/helm
```

HELM AI Enterprise source and release planning live at:

https://github.com/Mindburn-Labs/helm-ai-enterprise
