class Jjagent < Formula
  desc "CLI for tracking coding agent changes with jujutsu"
  homepage "https://github.com/schpet/jjagent"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.4/jjagent-aarch64-apple-darwin.tar.xz"
      sha256 "f7743e1b4a4bc801053866bd16d71bc9232246e6fc2bbe6f4db95e63ec60982f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.4/jjagent-x86_64-apple-darwin.tar.xz"
      sha256 "e74567099aa66ec8bfd815c5b2e6945b79f9f0c85b14d022c5399097303ee29a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.4/jjagent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e427d504c0861a7a7f6067e6b888fbd91bbef534df71ce2945fa41ae47dff0d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.4/jjagent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9c1a7e0d65779e4b824e4788bea2530938174a50a74372678992c3a3a59d595"
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
    bin.install "jjagent" if OS.mac? && Hardware::CPU.arm?
    bin.install "jjagent" if OS.mac? && Hardware::CPU.intel?
    bin.install "jjagent" if OS.linux? && Hardware::CPU.arm?
    bin.install "jjagent" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
