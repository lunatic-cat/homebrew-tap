# frozen_string_literal: true

require "net/http"
require "json"
require "uri"
PKG_NAME = /yggdrasil-([\d.]+)-macos-amd64.pkg/.freeze

cask "yggdrasil" do
  version :latest
  sha256 :no_check

  def yggdrasil_url_and_version
    uri = URI("https://circleci.com/api/v1.1/project/github/yggdrasil-network/yggdrasil-go/latest/artifacts")
    uri.query = "branch=master&filter=successful"
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      url = JSON.parse(http.request(Net::HTTP::Get.new(uri)).body).find { |a| a["path"] =~ PKG_NAME } ["url"]
      return [url, url.match(PKG_NAME)[1]]
    end
  end

  url yggdrasil_url_and_version[0]
  name "Yggdrasil"
  desc "End-to-end encrypted IPv6 networking to connect worlds"
  homepage "https://yggdrasil-network.github.io/"

  pkg "yggdrasil-#{yggdrasil_url_and_version[1]}-macos-amd64.pkg"

  uninstall launchctl: ["yggdrasil"], pkgutil: "io.github.yggdrasil-network.pkg"
end
