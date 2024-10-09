class Envset < Formula
  desc "command-line tool for setting environment variables in a .env file"
  homepage "https://github.com/schpet/envset"
  version "0.1.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/envset/releases/download/v0.1.17/envset-aarch64-apple-darwin.tar.xz"
      sha256 "1565088303afc86e1b9cc04ca8d81ff698dc1355644248f63e94137a4df51a69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/envset/releases/download/v0.1.17/envset-x86_64-apple-darwin.tar.xz"
      sha256 "c286d447074b3ecb270246caa74ad5863c1be8fb37f86ac47f6488a98db60ace"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/schpet/envset/releases/download/v0.1.17/envset-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "f4507af1ee59035ba0d1cb6ab6335c0072a0dd455763b0dc5986b47cdc54700c"
  end
  license "ISC"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "envset" if OS.mac? && Hardware::CPU.arm?
    bin.install "envset" if OS.mac? && Hardware::CPU.intel?
    bin.install "envset" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
