class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "1.11.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.1/linear-aarch64-apple-darwin.tar.xz"
      sha256 "bfdd3a0d727762018b5fdc2743ac9937fd708b0b3df70c73dad6acd627447694"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.1/linear-x86_64-apple-darwin.tar.xz"
      sha256 "7bcc1554fa562f04d415cfd0af9e067ffc3b32c902128bec44b54487ad6dd509"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.1/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2e3554742be571cf3e9aa7d2a4807a2fcbbea063d6bbc056c7e541d201e0e192"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.11.1/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4bbcf0c4e617c1898afb3732ba1baf556f098573c8e6181a5a2c84cfb4f48082"
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
