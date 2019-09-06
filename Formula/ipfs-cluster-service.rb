class IpfsClusterService < Formula
  desc "Pinset orchestration service for IPFS"
  homepage "https://cluster.ipfs.io/"
  url "https://dist.ipfs.io/ipfs-cluster-service/v0.10.1/ipfs-cluster-service_v0.10.1_darwin-amd64.tar.gz"
  sha256 "d93140dc127bf2c6a1548b1937084e0e3016c3059e23856a003f012f7243244d"

  depends_on "ipfs"

  conflicts_with "ipfs-cluster", :because => "both install an `ipfs-cluster-service` binary"

  def install
    bin.install "ipfs-cluster-service"
  end

  def caveats; <<~EOS
    Get <hash part of multiaddress of first peer> with `ipfs-cluster-ctl id` on existing node.
    Join a cluster with multiaddress (like /ip4/<ip>/tcp/<port>/ipfs/<hash>):

    $ export CLUSTER_SECRET=... ipfs-cluster-service init
    $ ipfs-cluster-service daemon --bootstrap <multiaddress of first peer>
  EOS
  end

  plist_options :manual => "ipfs-cluster-service daemon"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/ipfs-cluster-service</string>
        <string>daemon</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <dict>
        <key>Crashed</key>
        <true/>
        <key>SuccessfulExit</key>
        <false/>
      </dict>
      <key>ProcessType</key>
      <string>Background</string>
      <key>StandardErrorPath</key>
      <string>/usr/local/var/log/ipfs-cluster-service.log</string>
      <key>StandardOutPath</key>
      <string>/usr/local/var/log/ipfs-cluster-service.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/ipfs-cluster-service", "--version"
  end
end
