class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  url "https://github.com/schpet/stories/releases/download/v0.2.4/stories-x86_64-apple-darwin.tar.gz"
  sha256 "477ea3663210822357c2554390b6b8ee775079d09178b36858113dc3ac84b71f"
  license "MIT"

  def install
    bin.install "stories"
  end
end
