class Saturation < Formula
  desc "CLI for the Saturation public API and production finance resources"
  homepage "https://docs.saturation.io"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.1/saturation-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2c79a7b5fff713da46a87243d5380d0b2a56ad1032144b98b5fe8d29106a8fd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.1/saturation-cli-x86_64-apple-darwin.tar.xz"
      sha256 "efb330111dfccad980365137e04daa2c02c619d925c6a4a8663e46d3765bf398"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.1/saturation-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ec0760ff5a4821cf6c477b20e33a122fae65f496e76aef506234850946283d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.1/saturation-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "20205a1931f3a936a2cc665502321bfed9a16adba723d9bdff04b0974f1bd616"
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
      bin.install "saturation"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "saturation"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "saturation"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "saturation"
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
