class Svbump < Formula
  desc "CLI for reading and incrementing semvers in JSON, TOML, and YAML files"
  homepage "https://github.com/schpet/svbump"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v1.0.0/svbump-aarch64-apple-darwin.tar.xz"
      sha256 "60c9c12e4ee414d1328c621958a3a9539c6f078c14345c635604d76eabda4309"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v1.0.0/svbump-x86_64-apple-darwin.tar.xz"
      sha256 "e000981c4dcc72bf8e7ef89fbc2a7ffec68d5c1fe66b46595b1931c278bbe341"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v1.0.0/svbump-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9bb3897a9b525f14611c5cfd265740dc89aa6bb736e039b3a1cb50deff78cab2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v1.0.0/svbump-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5085e47d6dfd054a2eef24c445e856d012dad740d776b58d37fe761b6f3aad17"
    end
  end
  license "ISC"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "svbump" if OS.mac? && Hardware::CPU.arm?
    bin.install "svbump" if OS.mac? && Hardware::CPU.intel?
    bin.install "svbump" if OS.linux? && Hardware::CPU.arm?
    bin.install "svbump" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
