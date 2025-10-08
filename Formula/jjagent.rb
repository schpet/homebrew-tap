class Jjagent < Formula
  desc "CLI for tracking coding agent changes with jujutsu"
  homepage "https://github.com/schpet/jjagent"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.2/jjagent-aarch64-apple-darwin.tar.xz"
      sha256 "e19d09047956889a1d063edbd2a1e57af8b1dc7b2f8b43a6806762105b1b9fe8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.2/jjagent-x86_64-apple-darwin.tar.xz"
      sha256 "9df22843cf5e48785bbb78e2cbeb5cc16f9b423be794e7970f427bb7c2ce58c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.2/jjagent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d3b9e200d5e11595cec320da848d8a0a21a4860b61d7424d60ec3133d25b0570"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.2/jjagent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bcb8b94743a51139f228bea20fd20474c2a066cad7fa3d680e27ec01691d375e"
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
