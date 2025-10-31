class Pysubclasses < Formula
  desc "Tool for finding all subclasses (direct and transitive) of a Python class within a codebase"
  homepage "https://github.com/Peter554/pysubclasses"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Peter554/pysubclasses/releases/download/v0.1.1/pysubclasses-aarch64-apple-darwin.tar.xz"
      sha256 "704062added1876dd3c340645a44ab102adf94e1ad9748b437977ae8cfa844f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Peter554/pysubclasses/releases/download/v0.1.1/pysubclasses-x86_64-apple-darwin.tar.xz"
      sha256 "8ff86b13cdf563b7639c62ef7ea790444f7f8564c37c40342fe8a49bdcfa7467"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Peter554/pysubclasses/releases/download/v0.1.1/pysubclasses-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d02d0a960f24fd9a176a88e3f642513935ea7dbcfb6c69a8dd6ef7b25f5e6341"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Peter554/pysubclasses/releases/download/v0.1.1/pysubclasses-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfe5f6ff166af7c2048fb146711322b8cbfb676ac0760e556eb416fd3022eae8"
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
    bin.install "pysubclasses" if OS.mac? && Hardware::CPU.arm?
    bin.install "pysubclasses" if OS.mac? && Hardware::CPU.intel?
    bin.install "pysubclasses" if OS.linux? && Hardware::CPU.arm?
    bin.install "pysubclasses" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
