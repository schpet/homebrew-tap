class Mdmd < Formula
  desc "A TUI markdown viewer and navigator"
  homepage "https://github.com/schpet/mdmd"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.6.0/mdmd-aarch64-apple-darwin.tar.xz"
      sha256 "a6c8dc143b7143f4d03fb3fbcc960fa9a8edaa3d855dc988debe7a7eb91f1091"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.6.0/mdmd-x86_64-apple-darwin.tar.xz"
      sha256 "2bbb869dcd9125518e6252bd4c6d32bdc1b486748b4340570e718d2bf716f9e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.6.0/mdmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "94ab3043b6687190d5f16eb21ae40605aeca716b91ec131e379c75d082ada246"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.6.0/mdmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "720eb5496738a349726984000feaab3946ecfd48c522b5987109018b450cc60b"
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
