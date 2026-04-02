class Timeslip < Formula
  desc "CLI for managing time entries (add, update, remove, list) plus listing projects and clients"
  homepage "https://github.com/schpet/timeslip"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/timeslip/releases/download/v0.1.0/timeslip-aarch64-apple-darwin.tar.xz"
      sha256 "77158ab347b7c7e422bcf8caae666635944baf08c5915f3a5f53860322b6e228"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/timeslip/releases/download/v0.1.0/timeslip-x86_64-apple-darwin.tar.xz"
      sha256 "6adec844489588490b4244fbb2a925818955be13e54faad1df70d5ae66eafb00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/timeslip/releases/download/v0.1.0/timeslip-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2aaa06e289ac295b9f72267280eea207f13eaa8e9cb5b52c5d4197f0bf51c009"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/timeslip/releases/download/v0.1.0/timeslip-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff7d5037fe8d5ec71a9425d17b07b85c22bdb0bb5b07257524aa61431b6f12e5"
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
    bin.install "timeslip" if OS.mac? && Hardware::CPU.arm?
    bin.install "timeslip" if OS.mac? && Hardware::CPU.intel?
    bin.install "timeslip" if OS.linux? && Hardware::CPU.arm?
    bin.install "timeslip" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
