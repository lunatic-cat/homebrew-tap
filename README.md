# Various goodies as a Homebrew tap

## Install

```bash
brew tap lunatic-cat/tap
```

## SquashFS + ZSTd

This conflicts with squashfs@homebrew-core. 
You can cafely uninstall it, this is drop-in replacement.

```bash
brew install lunatic-cat/tap/squashfs
```

[upstream PR](https://github.com/Homebrew/homebrew-core/pull/43253) & [patch PR](https://github.com/Homebrew/formula-patches/pull/277)
