class Courtside < Formula
  desc "Validate, convert and summarise volleyball scouting files"
  homepage "https://github.com/cillianbc/courtside-cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cillianbc/courtside/releases/download/v0.1.0/courtside-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9748938695cfc037560b1e1099df3e0b09b70debd209f40bb5b719203d111e2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cillianbc/courtside/releases/download/v0.1.0/courtside-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bedf9c848d6ade23484cfab25be1a4d9e01880e56e0274d0d42a420701d536be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cillianbc/courtside/releases/download/v0.1.0/courtside-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b678efe7d58d24c6c83c0e6fe9dacb80a7c35a532c7e7f2c50d350f548b345b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cillianbc/courtside/releases/download/v0.1.0/courtside-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac7f8c669d379fadc99f6f75ddaef929a3b329f46a2db9266d971ca7db5958e2"
    end
  end
  license "UNLICENSED"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
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
      bin.install "courtside"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "courtside"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "courtside"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "courtside"
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
