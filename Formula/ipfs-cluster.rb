class IpfsCluster < Formula
  desc "Pinset orchestration for IPFS built from source"
  homepage "https://cluster.ipfs.io/"
  url "https://github.com/ipfs/ipfs-cluster.git",
      :tag      => "v0.10.1",
      :revision => "0f9ce4807cc330f010bed6397f8670d0512f3b29"
  head "https://github.com/ipfs/ipfs-cluster.git"

  depends_on "go" => :build
  depends_on "ipfs"

  conflicts_with "ipfs-cluster-ctl", :because => "both install an `ipfs-cluster-ctl` binary"
  conflicts_with "ipfs-cluster-service", :because => "both install an `ipfs-cluster-service` binary"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    (buildpath/"src/github.com/ipfs/ipfs-cluster").install buildpath.children
    cd("src/github.com/ipfs/ipfs-cluster") { system "make", "install" }
    bin.install "bin/ipfs-cluster-service"
    bin.install "bin/ipfs-cluster-ctl"
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
    system "#{bin}/ipfs-cluster-ctl", "--version"
    system "#{bin}/ipfs-cluster-service", "--version"
  end
end
