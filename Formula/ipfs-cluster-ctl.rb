class IpfsClusterCtl < Formula
  desc "Pinset orchestration cli for IPFS"
  homepage "https://cluster.ipfs.io/"
  url "https://dist.ipfs.io/ipfs-cluster-ctl/v0.10.1/ipfs-cluster-ctl_v0.10.1_darwin-amd64.tar.gz"
  sha256 "9203a29796821393963420e1464a81d058fe1ed88af4acb23ace17ec71352ad9"

  depends_on "ipfs"

  conflicts_with "ipfs-cluster", :because => "both install an `ipfs-cluster-ctl` binary"

  def install
    bin.install "ipfs-cluster-ctl"
  end

  test do
    system "#{bin}/ipfs-cluster-ctl", "--version"
  end
end
