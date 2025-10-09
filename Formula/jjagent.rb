class Jjagent < Formula
  desc "CLI for tracking coding agent changes with jujutsu"
  homepage "https://github.com/schpet/jjagent"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.3/jjagent-aarch64-apple-darwin.tar.xz"
      sha256 "eb88f45be2fee1ab7e5bf74b7e6aa2b468f620cb62eb2b71ac5935499d8e9ff2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.3/jjagent-x86_64-apple-darwin.tar.xz"
      sha256 "54e6b52e05da8ba09b225bfbecc1c886883482bffc707a572991d731b5d28ca5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.3/jjagent-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d85dddfe6318934551e451a066c8d32ad8ef6dd6ee6967a90852ea0c81e14537"
    end
    if Hardware::CPU.intel?
      url "https://github.com/schpet/jjagent/releases/download/v0.2.3/jjagent-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68df88e5950f8b33abf6ab08232cb6440fa2ad3229cbff17e3e803d9c3643d49"
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
