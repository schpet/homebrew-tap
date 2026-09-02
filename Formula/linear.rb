class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "2.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.6.0/linear-aarch64-apple-darwin.tar.xz"
      sha256 "b9abdd4b5aec14459e434a2899203757de8ae847f055eae4f1faee7bb1fbc078"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.6.0/linear-x86_64-apple-darwin.tar.xz"
      sha256 "08aba19af4f00629e5e89ab04017d31d18573fbc9dc922280828702fdae27a3f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.6.0/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55cc4a6b2489a403ad9eb80f612dfa841287bfa16b98390bb4d4e072d79e2361"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.6.0/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbcb9d365308bc3728a1ec9913ad1880f88c0ce68767383297e348c057f35b8d"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "linear"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "linear"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "linear"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "linear"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
