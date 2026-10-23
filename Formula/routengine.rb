class Routengine < Formula
  desc "Choose which network adapter each app uses (command line)"
  homepage "https://routengine.net"
  license "PolyForm-Noncommercial-1.0.0"

  livecheck do
    url "https://github.com/champdev-me/routengine/releases/latest"
    strategy :github_latest
  end

  # One universal macOS build serves both Apple Silicon and Intel.
  on_macos do
    url "https://github.com/champdev-me/routengine/releases/download/v1.1.0/routengine-1.1.0-mac.tar.gz"
    sha256 "5bf3634daeb8417442078b822f207b2f7e328d69dcb6a69cb68591a2b4c7cfb3"
  end

  on_linux do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.0/routengine-1.1.0-linux-arm64.tar.gz"
      sha256 "dd7e3a8ea57d417e2656ff890abb0d1831e7521acd77ea44bd19bd373e531cc5"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.1.0/routengine-1.1.0-linux-amd64.tar.gz"
      sha256 "410e544f744454f53ea5a7b58ca34b578050ce5400b1e9624ad6b4c13171bd43"
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
