class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  url "https://github.com/schpet/stories/releases/download/v0.1.1/stories-x86_64-apple-darwin.tar.gz"
  sha256 "d59cb2dded6b89e72a87a8dc592e3a9f1fd2cb5539cda467d98af1a2efc44675"
  license "MIT"

  def install
    bin.install "stories"
  end
end
