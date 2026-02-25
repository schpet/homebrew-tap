class Mdmd < Formula
  desc "A TUI markdown viewer and navigator"
  homepage "https://github.com/schpet/mdmd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.1.0/mdmd-aarch64-apple-darwin.tar.xz"
      sha256 "ccb4872c355b094f4ac78f4d6e381be500b5f791cd95981803533a1bbb0c4bdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.1.0/mdmd-x86_64-apple-darwin.tar.xz"
      sha256 "ff4b57768e26ae0e82fc1060adcf7949ded47a1708abaf16f736b092d019945d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.1.0/mdmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a02aede6c543199fb904dcebcbfbed566544e2c70838fef626eb050e3ecae6ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.1.0/mdmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "931778142cbca8e655a68c1b13517c02274f08a24a949e40fc39a985da478c73"
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
