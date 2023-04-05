class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.3.0"

  url "https://github.com/schpet/stories/releases/download/v0.3.0/stories-x86_64-apple-darwin.tar.gz"
  sha256 "e8e96b16ab052d28d0e5e37756db09b665b4b3804358169525f48e5e6bc56d03"

  def install
    bin.install("stories")
  end
end
