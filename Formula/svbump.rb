class Svbump < Formula
  desc "A cli for reading and incrementing semvers in JSON, TOML, and YAML files"
  homepage "https://github.com/schpet/svbump"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v0.1.5/svbump-aarch64-apple-darwin.tar.xz"
      sha256 "f56f4c5891236f77d8f7ccc4941beac244c3eeb78b5576996fbcc5643bb7b8ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v0.1.5/svbump-x86_64-apple-darwin.tar.xz"
      sha256 "2575599db409752a5d406975db34cab87429afa76197a626fd02c9466de80b52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v0.1.5/svbump-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4145f564adde77f27deeed91c5e80bd2d12bd25dfb6c2fe954d5c16481b21bfd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v0.1.5/svbump-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0327942a7be7887dc67e5fb76f36f0e0943896c391e15a12cc2178675f2ae3bc"
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
