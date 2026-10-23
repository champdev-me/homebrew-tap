class Routengine < Formula
  desc "Choose which network adapter each app uses (command-line version)"
  homepage "https://routengine.net"
  license "PolyForm-Noncommercial-1.0.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # One universal macOS build serves both Apple Silicon and Intel.
  # One universal macOS build serves both Apple Silicon and Intel.
  on_macos do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.1/routengine-1.1.1-mac.tar.gz"
      sha256 "d02a05fa16421fa00c0a138c8ab28774dec31d9c781cd813c9d6f5524faa119d"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.1/routengine-1.1.1-mac.tar.gz"
      sha256 "d02a05fa16421fa00c0a138c8ab28774dec31d9c781cd813c9d6f5524faa119d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.1/routengine-1.1.1-linux-arm64.tar.gz"
      sha256 "41505f2c6d1a0beb8d7dbc4d66656108fb130b1d028fb95bdc7b376bedc9d8dd"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.1/routengine-1.1.1-linux-amd64.tar.gz"
      sha256 "7f995bb32fc2842d922f015670e2976ffd748b90301586d459b61e6bfa41face"
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
      The free edition needs no key. For Pro: routengine machine-code, then routengine license add <key>.
      Docs: https://github.com/champdev-me/routengine/blob/main/docs/cli.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/routengine version")
  end
end
