class Mdmd < Formula
  desc "A TUI markdown viewer and navigator"
  homepage "https://github.com/schpet/mdmd"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.2/mdmd-aarch64-apple-darwin.tar.xz"
      sha256 "961ddb8533497375398b8ed9a5372315419fa4ce077598f120dbb2e6f0cc7745"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.2/mdmd-x86_64-apple-darwin.tar.xz"
      sha256 "2fb1302c333b46f8a4cd6475732e49cf2d745a4f2856055716754c55ec0c6fa3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.2/mdmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff12b239b0150e1a6f7aeeb2b49041970e7db616ce747c1c3958822af99ff4bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.2/mdmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "97557b46ffe85516fa2628f8e72ef21170b9703575ac4433e0b7ec8299aa80a2"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "mdmd" if OS.mac? && Hardware::CPU.arm?
    bin.install "mdmd" if OS.mac? && Hardware::CPU.intel?
    bin.install "mdmd" if OS.linux? && Hardware::CPU.arm?
    bin.install "mdmd" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
