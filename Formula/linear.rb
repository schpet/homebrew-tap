class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v0.3.1/linear-aarch64-apple-darwin.tar.xz"
      sha256 "03d8e9ea0f9f03ef8f504a1b0f9d3f13be1452775ef03d678abc80f79b9d6b61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v0.3.1/linear-x86_64-apple-darwin.tar.xz"
      sha256 "b6f01ca12d74894df00d07e9cf1be98a85647f6ac4e76a43fa6085a793d79c2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v0.3.1/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "869089af939416a2775c070ae8b6b4ce1d80ccb00af5220c67cc7c054fc6ea03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v0.3.1/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "801045a5191273eae42e211538895f151596b390632104157e3c846b38399f33"
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
    bin.install "linear" if OS.mac? && Hardware::CPU.arm?
    bin.install "linear" if OS.mac? && Hardware::CPU.intel?
    bin.install "linear" if OS.linux? && Hardware::CPU.arm?
    bin.install "linear" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
