class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.2.7"

  url "https://github.com/schpet/stories/releases/download/v0.2.7/stories-x86_64-apple-darwin.tar.gz"
  sha256 "44247cff547f9e33f0ae220ed5eaf5693d0a42029ee7dd2de687b0d9700e43f9"

  def install
    bin.install("stories")
  end
end
