class Saturation < Formula
  desc "CLI for the Saturation public API and production finance resources"
  homepage "https://docs.saturation.io"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.0/saturation-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fe5ee55365397d4631734de1dbd536952dd5a3870d34966a3d364c7960bf4590"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.0/saturation-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fdd23045ef1ec2be22ecfceb0d1a3094f8ab734852f880ba2efc9b9279651323"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.0/saturation-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae2da7e78140d4e04ad9f8f718340d6b1f44a42bed42af9453445ce0df9172d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Saturation-IO/saturation-cli/releases/download/v0.2.0/saturation-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "77368ce66702d63dc1f8d6f356d98579bbea1e407d7f665bd7ff8f7544a13cef"
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
