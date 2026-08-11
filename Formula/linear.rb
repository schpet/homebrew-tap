class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "2.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.5.0/linear-aarch64-apple-darwin.tar.xz"
      sha256 "6d11eb5a0ee2aa10d24625d23c605bf56987a94741e60bb9817f87b123a9a00b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.5.0/linear-x86_64-apple-darwin.tar.xz"
      sha256 "f57c7acc974c1bc01c0ac141658a2fd380e36776b85f15da9fcbf2e824c0823c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v2.5.0/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c8ddd7fb478ff23cd752026eb609f25ef91cc36cb1b55900db9f182f4aeb47b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v2.5.0/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "62accf1eb36c31e897f8490e826182f012b9a4b3a2c0d3bf8c8dde906039c3ea"
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
