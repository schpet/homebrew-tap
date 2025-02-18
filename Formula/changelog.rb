class Changelog < Formula
  desc "CLI for updating a CHANGELOG.md"
  homepage "https://github.com/schpet/changelog"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/changelog/releases/download/v1.0.0/changelog-aarch64-apple-darwin.tar.xz"
      sha256 "e97ee0101a939cdd8f5f76cf0b21dc6f5b30ad6ded6ae3a50c37ed0108a3eb0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/changelog/releases/download/v1.0.0/changelog-x86_64-apple-darwin.tar.xz"
      sha256 "3c8abf1bd983bafb87cc84a99c1e636af6f79c0825493f79daf851423e7033eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/changelog/releases/download/v1.0.0/changelog-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "516eeb95cde69903339a3a31ce323c17e61f3aaf4b71256eb638a5a4105e9237"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/changelog/releases/download/v1.0.0/changelog-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2981047f46e622173575cf46bf50c32c1ae83dfdde7e3754d4fddc094562a5d9"
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
    bin.install "changelog" if OS.mac? && Hardware::CPU.arm?
    bin.install "changelog" if OS.mac? && Hardware::CPU.intel?
    bin.install "changelog" if OS.linux? && Hardware::CPU.arm?
    bin.install "changelog" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
