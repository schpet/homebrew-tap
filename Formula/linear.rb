class Linear < Formula
  desc "CLI tool for linear.app that uses git branch names and directory names to open issues and team pages"
  homepage "https://github.com/schpet/linear-cli"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.2.1/linear-aarch64-apple-darwin.tar.xz"
      sha256 "1b73d8db5823ec0315d9046d6b0f6e075b9740e6abfa1f74f76097d85f685efb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.2.1/linear-x86_64-apple-darwin.tar.xz"
      sha256 "174f956501a641eaf303f4032e55a960e2fab8b349d4d50b753e00fec3d4fa17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v1.2.1/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17cee1ebbcdb9dd770f4c64f3adb0e4f89cfbcc374cec10fd5e58529d34143d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v1.2.1/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f6747380716f3d2c8a6788cf13646bd81a54988ffd34c057da5778eb37a6d599"
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
