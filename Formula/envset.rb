class Envset < Formula
  desc "A tool to set environment variables from .env files"
  homepage "https://github.com/schpet/envset"
  url "https://github.com/schpet/envset.git"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"test.env").write <<~EOS
      FOO=bar
    EOS
    assert_match "FOO=bar", shell_output("#{bin}/envset -f #{testpath}/test.env")
  end
end
