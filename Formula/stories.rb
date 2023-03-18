class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.2.6"

  on_macos do
    url "https://github.com/schpet/stories/releases/download/v0.2.6/stories-x86_64-apple-darwin.tar.gz"
    sha256 "011053f98d26c7f51ec6211c495898901d742d3b55c0f8ad92287982a8a36d1e"
  end

  def install
    bin.install("stories")
  end
end
