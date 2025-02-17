class Changelog < Formula
  desc "CLI for updating a CHANGELOG.md"
  homepage "https://github.com/schpet/changelog"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/changelog/releases/download/v0.1.3/changelog-aarch64-apple-darwin.tar.xz"
      sha256 "bfc1a635148498928644cca88d5e1289070823cf1c5839928344d3f0a24654ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/changelog/releases/download/v0.1.3/changelog-x86_64-apple-darwin.tar.xz"
      sha256 "42bf4b13ec4e99fd8993c20cee34781141c884d7148d3fe7b02bed26ef4d88a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/changelog/releases/download/v0.1.3/changelog-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5569ff12ce708472b165477c8fc1d627e32ca87a69269a79fc6a8715ef792cb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/changelog/releases/download/v0.1.3/changelog-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4808272206889462da5b8a2a45e559fefac1d9830da5ac3e6317c8c482da3e51"
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
