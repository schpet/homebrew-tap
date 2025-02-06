class Envset < Formula
  desc "A command-line tool for setting environment variables in a .env file"
  homepage "https://github.com/schpet/envset"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/envset/releases/download/v0.2.0/envset-aarch64-apple-darwin.tar.xz"
      sha256 "74f4fc56cabc9944b8ba8f141dd3234e5eefbdb5bc5e071bbc29da4c181fe1c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/envset/releases/download/v0.2.0/envset-x86_64-apple-darwin.tar.xz"
      sha256 "29b6b24ccbb1a905bffae81607dc10b0fb0433b2ccfceded6740666d42c81f12"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/schpet/envset/releases/download/v0.2.0/envset-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "fa7ea7fa7d4a9aee6a971bbec814fa743b377b60347e22da57a44f572ded63d0"
  end
  license "ISC"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "envset" if OS.mac? && Hardware::CPU.arm?
    bin.install "envset" if OS.mac? && Hardware::CPU.intel?
    bin.install "envset" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
