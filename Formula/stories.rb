class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.5.1"

  url "https://github.com/schpet/stories/releases/download/v0.5.1/stories-x86_64-apple-darwin.tar.gz"
  sha256 "dc5b02f4dcbe8c9f7138cdb4fd9ddecc3f2d399fe8f1e99d5fd600877efb8d17"

  def install
    bin.install("stories")
  end
end
