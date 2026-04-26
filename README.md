# Mindburn Labs Homebrew Tap

Formulae for Mindburn Labs command-line tools.

## Install HELM OSS

```sh
brew install Mindburn-Labs/homebrew-tap/helm
```

The short alias also works:

```sh
brew install mindburn-labs/tap/helm
```

Then run:

```sh
helm serve --policy ./release.high_risk.v3.toml
```

This installs the HELM OSS boundary CLI from the release binaries published at:

https://github.com/Mindburn-Labs/helm-oss/releases

## Notes

The formula name is `helm` because the public HELM OSS quickstart uses `helm`.
This can conflict with Kubernetes Helm, which also uses the `helm` formula and
binary name in Homebrew core.

The intended public namespace remains:

```sh
brew install mindburn/tap/helm
```

That path requires the GitHub repository `mindburn/homebrew-tap`. Homebrew maps
repositories named `homebrew-*` to short tap names, so `mindburn/homebrew-tap`
becomes `mindburn/tap`. Until that repository is available under the `mindburn`
GitHub user, this org tap provides the working install paths:

```sh
brew install Mindburn-Labs/homebrew-tap/helm
brew install mindburn-labs/tap/helm
```

## Other Formulae

Use:

```sh
brew install Mindburn-Labs/homebrew-tap/<formula>
brew install mindburn-labs/tap/<formula>
```

Or:

```sh
brew tap mindburn-labs/tap
brew install <formula>
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "mindburn-labs/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
