class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "1.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.0/linear-aarch64-apple-darwin.tar.xz"
      sha256 "15e5be7662acedf7aed41b4c32285c4cf62d032cb608c2e3f63f132b99d27d53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.0/linear-x86_64-apple-darwin.tar.xz"
      sha256 "aaf4cf94ee3cbe8db19d594da607c2449b1bd0674b9252d38975b257aaa41ed1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.0/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c793a0f5e12d79e8145055ea9a41378ac84f02d09f53e98a11b49f7489435b32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.0/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9d80b07fb8cc70132003148a07d24384911131f52295ae8520622c30ea4bbbf0"
    end
  end
  license "MIT"

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
    bin.install "linear" if OS.mac? && Hardware::CPU.arm?
    bin.install "linear" if OS.mac? && Hardware::CPU.intel?
    bin.install "linear" if OS.linux? && Hardware::CPU.arm?
    bin.install "linear" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
