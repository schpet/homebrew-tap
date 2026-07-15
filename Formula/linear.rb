class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.1.0/linear-aarch64-apple-darwin.tar.xz"
      sha256 "e1ad596cea80327caa6cb5fbfff3a8cfd1e92027ab75ee267d85cd45c32ccabc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.1.0/linear-x86_64-apple-darwin.tar.xz"
      sha256 "b3e3e85c0462b65b97e84f801c2f78efa9a2835a2b3594aa4b6064dc9c8c037a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.1.0/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78b261fd3c8fc5ec9568470c1a20106134cb1c6587ab2ddf52127cdd9de01357"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.1.0/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1371df083f1f164fed3c6df414a2facdc6e5d3be27c355f173138248238c13e3"
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
