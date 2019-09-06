# Various goodies as a Homebrew tap

## Install

```bash
brew tap lunatic-cat/tap
```

## IPFS cluster

```bash
brew install ipfs-cluster-ctl
brew install ipfs-cluster-service
```

or if you want to build both from source

```bash
brew install ipfs-cluster
```

## SquashFS + ZSTd

This conflicts with squashfs@homebrew-core. 
You can cafely uninstall it, this is drop-in replacement.

```bash
brew install lunatic-cat/tap/squashfs
```

### Usage

Reading image on OSX requires [osxfuse](https://osxfuse.github.io/) & [squashfuse](https://github.com/vasi/squashfuse)

```bash
# archive
mksquashfs dir dir.zstd.sfs -comp zstd -Xcompression-level 22
# osx usage
squashfuse dir.zstd.sfs mnt
# linux usage
mount -o loop dir.zstd.sfs mnt
```

[upstream PR](https://github.com/Homebrew/homebrew-core/pull/43253) & [patch PR](https://github.com/Homebrew/formula-patches/pull/277)
