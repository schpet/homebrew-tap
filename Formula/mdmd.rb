class Mdmd < Formula
  desc "A TUI markdown viewer and navigator"
  homepage "https://github.com/schpet/mdmd"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.4/mdmd-aarch64-apple-darwin.tar.xz"
      sha256 "41ee0bda0d2f87da12fcb9f24c4d2f604853ae0375e5c6245a2e867d7b62e582"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.4/mdmd-x86_64-apple-darwin.tar.xz"
      sha256 "13edb181c38d59f5b1c6f20de3ff50876af71003b71a8c7508ad6596071eadc4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.4/mdmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "617118d03d24b9e7b9252990e8d56a4424c017854784c0228cc88ba7791c2e17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.2.4/mdmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "17b73df146083949718cad07778f6489d4045fd027e8e5dda9d870e9774132c6"
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
