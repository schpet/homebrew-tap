class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  url "https://github.com/schpet/stories/archive/v0.2.0.tar.gz"
  sha256 "013625e3b2c6bfa0cd19c3c669f7fe3c12d3b20bcd5dd594a6610dc086b533f7"
  license "MIT"

  def install
    bin.install "stories"
  end
end
