class Routengine < Formula
  desc "Choose which network adapter each app uses (command-line version)"
  homepage "https://routengine.net"
  license "PolyForm-Noncommercial-1.0.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # One universal macOS build serves both Apple Silicon and Intel.
  on_macos do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.2/routengine-1.2.2-mac.tar.gz"
      sha256 "de5404dfc0c73299a2b634f43cfdd88b9b707467c14e4da52e6e51de9ecd29ff"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.2/routengine-1.2.2-mac.tar.gz"
      sha256 "de5404dfc0c73299a2b634f43cfdd88b9b707467c14e4da52e6e51de9ecd29ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.2/routengine-1.2.2-linux-arm64.tar.gz"
      sha256 "aa4cddab003fac6bfe27c2fec7016377e51818cb8c1285d0e691bc2ca7263c81"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.2/routengine-1.2.2-linux-amd64.tar.gz"
      sha256 "ae60f68b4535a570cb5efd6aadf5c6ee44afdaead7cb898f3225f492fcf62cc5"
    end
  end

  def install
    bin.install "routengine"
  end

  def caveats
    <<~EOS
      Routing needs root to create its virtual adapter:
        sudo #{opt_bin}/routengine run
      Rules go in config.json (as root on Linux: /etc/routengine; otherwise your config folder).
      Free for any use, work included, on any number of apps. No key needed.
      Docs: https://github.com/champdev-me/routengine/blob/main/docs/cli.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/routengine version")
  end
end
