class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.3.2"

  url "https://github.com/schpet/stories/releases/download/v0.3.2/stories-x86_64-apple-darwin.tar.gz"
  sha256 "92b6b019ed7e7df66a8e51cd6e165c70e7194f9f99d83328ec0eb45de7d8b111"

  def install
    bin.install("stories")
  end
end
