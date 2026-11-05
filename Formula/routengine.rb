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
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.3/routengine-1.2.3-mac.tar.gz"
      sha256 "cfe7c20fcdebb6fa2d5ce5217a021456e77afee51a37323a73d36ec6a7259d1e"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.3/routengine-1.2.3-mac.tar.gz"
      sha256 "cfe7c20fcdebb6fa2d5ce5217a021456e77afee51a37323a73d36ec6a7259d1e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.3/routengine-1.2.3-linux-arm64.tar.gz"
      sha256 "277e81fde7b3574c5db5aab5029aad047503651d6d995b0e9527a1c1a81f7236"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.3/routengine-1.2.3-linux-amd64.tar.gz"
      sha256 "eedcead855198cfb65eeeea3959ce9c498d6d6e696d630b594b8a0d9c0a5577b"
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
