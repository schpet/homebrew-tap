class Jjagent < Formula
  desc "CLI for tracking coding agent changes with jujutsu"
  homepage "https://github.com/schpet/jjagent"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.1/jjagent-aarch64-apple-darwin.tar.xz"
      sha256 "eb78d3c954aac5a26471421ba396b3ad4e585326856dcc6b9715bb0dcdbc882c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.1/jjagent-x86_64-apple-darwin.tar.xz"
      sha256 "72a112775e17fd43e4a06b447e8289de830f72180a56b62fef3c273e57c45fae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.1/jjagent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d21fed6525996f70e931fa4b2a7d71a6db5a1d25dff23a7922acb5ddb52b55f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.1/jjagent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "052a2affe858ebbfa6a873efed9ae4bb0ee34c03923aca29c8e11d59aa5cdfc0"
    end
  end

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
    bin.install "jjagent" if OS.mac? && Hardware::CPU.arm?
    bin.install "jjagent" if OS.mac? && Hardware::CPU.intel?
    bin.install "jjagent" if OS.linux? && Hardware::CPU.arm?
    bin.install "jjagent" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
