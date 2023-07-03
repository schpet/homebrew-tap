class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.5.0"

  url "https://github.com/schpet/stories/releases/download/v0.5.0/stories-x86_64-apple-darwin.tar.gz"
  sha256 "53a2d868f662da848b28d58a9dc486c47f71245b7062f43d8f9c7ea95ca669df"

  def install
    bin.install("stories")
  end
end
