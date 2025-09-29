class Jjagent < Formula
  desc "CLI for tracking coding agent changes with jujutsu"
  homepage "https://github.com/schpet/jjagent"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.1.3/jjagent-aarch64-apple-darwin.tar.xz"
      sha256 "71522c5e8721905535468a1db75598e124dea4cc4a5e79edee382615d295c3f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.1.3/jjagent-x86_64-apple-darwin.tar.xz"
      sha256 "b66e69fbd1f31a568c10ea991f6db3bf411d96e64e83dbeadaa777e6f268b441"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.1.3/jjagent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca33368fe0814dc8e1ad43894950f26ec3a99ab2f90986261a0dcd2aafe5e89a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.1.3/jjagent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98da80d57c626b7c415e3ff7aa698df233064f54e4f3529ad58783debe2874c7"
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
