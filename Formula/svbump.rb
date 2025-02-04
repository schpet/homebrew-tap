class Svbump < Formula
  desc "A cli for reading and incrementing semvers in JSON, TOML, and YAML files"
  homepage "https://github.com/schpet/svbump"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v0.1.3/svbump-aarch64-apple-darwin.tar.xz"
      sha256 "90837fa98108ea33089caa7ce5336dcc40d0064a27a3c6a906e78520dcc5c112"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v0.1.3/svbump-x86_64-apple-darwin.tar.xz"
      sha256 "633bf5e33cdadc1f33f4afa29526df891a80b52007e3b1a06e755f42d95e4fb0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/svbump/releases/download/v0.1.3/svbump-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "621efa9f95df786d57dcda8557be26e5acf28456fac89421c15045dc5bf1198d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/svbump/releases/download/v0.1.3/svbump-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c5b3443c72c19e7b9e9079f6ad34d91842b9e9bb752bb958214c7276dc935dfd"
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
