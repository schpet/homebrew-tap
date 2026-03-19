class Mdmd < Formula
  desc "A TUI markdown viewer and navigator"
  homepage "https://github.com/schpet/mdmd"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.4.0/mdmd-aarch64-apple-darwin.tar.xz"
      sha256 "219316475725d55d661bef046f2ad04c590a95a26fe6229e678eb6856d47eefe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.4.0/mdmd-x86_64-apple-darwin.tar.xz"
      sha256 "cca883f644504407cbc960a49555e229063c52c4c25a7804fbf57425e8cb7a36"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/mdmd/releases/download/v0.4.0/mdmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12368461abc379739762e137c8adb07d6c1000a8b17564ff19a9843e2209b72c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/mdmd/releases/download/v0.4.0/mdmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "037cecb87fd3ba580ac3398930d12c2b474d86bbb260b5de1c616d3e8ee1ab50"
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
