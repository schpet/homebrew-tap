class Stories < Formula
  desc "CLI for pivotal tracker"
  homepage "https://github.com/schpet/stories"
  license "MIT"
  version "0.2.5"

  on_macos do
    url "https://github.com/schpet/stories/releases/download/v0.2.5/stories-x86_64-apple-darwin.tar.gz"
    sha256 "4e3ff95d7cebbf19dd4efcfbe8649111c273996a590d19ff8bdad7627fd2e8e9"
  end

  def install
    bin.install("stories")
  end
end
