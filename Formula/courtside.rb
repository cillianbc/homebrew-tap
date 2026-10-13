class Courtside < Formula
  desc "Validate, convert and summarise volleyball scouting files"
  homepage "https://github.com/cillianbc/courtside-cli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cillianbc/courtside-cli/releases/download/v0.2.0/courtside-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9340d6d06620aedc659dafd55c8278f0d8cace1d13794232ad43ae5344c60380"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cillianbc/courtside-cli/releases/download/v0.2.0/courtside-cli-x86_64-apple-darwin.tar.xz"
      sha256 "00785899e955f0338545b003c1584e3f3d2ee2f94ff5524bf58dc432d10ae78c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cillianbc/courtside-cli/releases/download/v0.2.0/courtside-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "71ab37bfb39d02ed13ade7b7a3b9c6e1be81bb4250ff038f2f29217baa4f7ebc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cillianbc/courtside-cli/releases/download/v0.2.0/courtside-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9900553f7877eef377a2c7dad2d1adc1c4cba154413284dc696fab01bde3b8ce"
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
