class Envset < Formula
  desc "A tool to write environment variables to .env files"
  homepage "https://github.com/schpet/envset"
  url "https://github.com/schpet/envset.git", tag: "v0.1.13"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/envset", "FOO=bar"
    assert_equal "FOO=bar\n", File.read(".env")
  end
end
