class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.4.0"

  url "https://github.com/schpet/stories/releases/download/v0.4.0/stories-x86_64-apple-darwin.tar.gz"
  sha256 "644a5e35d39da6879421da1583a2baa63d4ff0f7ee956ccd64a357e4b92d5758"

  def install
    bin.install("stories")
  end
end
