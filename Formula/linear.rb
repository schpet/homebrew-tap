class Linear < Formula
  desc "Work with Linear issues, projects and teams from the command line"
  homepage "https://github.com/schpet/linear-cli"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v3.0.0/linear-aarch64-apple-darwin.tar.xz"
      sha256 "85eb84e795544a577adc17b96f8b00771bcec94f38d26442fd7d561cd82336f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v3.0.0/linear-x86_64-apple-darwin.tar.xz"
      sha256 "723c32e044453818f0b539c2dd8da20a815a9683442499058e1069a711f726ab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/linear-cli/releases/download/v3.0.0/linear-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f6580185f3a07c558c64de44506d7ae56c13615c7d2139e5cd22ff3b03822fcd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/linear-cli/releases/download/v3.0.0/linear-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5064a63a7e6a8b5893a550e138c0a7ba373aad65d425dde6b2b66b50a6c10289"
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
