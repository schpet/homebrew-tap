class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.3.1"

  url "https://github.com/schpet/stories/releases/download/v0.3.1/stories-x86_64-apple-darwin.tar.gz"
  sha256 "037a4cbb9375a62b9359625d16147964e13220f2940bb1d53da12ff1bd005e17"

  def install
    bin.install("stories")
  end
end
