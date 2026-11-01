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
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.1/routengine-1.2.1-mac.tar.gz"
      sha256 "13d0f2468f3f7876b4a86bb90a9efa3f10b33a84d5147ab25b87083c26f73a8d"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.1/routengine-1.2.1-mac.tar.gz"
      sha256 "13d0f2468f3f7876b4a86bb90a9efa3f10b33a84d5147ab25b87083c26f73a8d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.1/routengine-1.2.1-linux-arm64.tar.gz"
      sha256 "3694644b670971be0b23aff6d56c1c4d54c625fd6b23a1528ebfbca0646610cf"
    end
    on_intel do
      url "https://github.com/champdev-me/routengine/releases/download/v1.2.1/routengine-1.2.1-linux-amd64.tar.gz"
      sha256 "1749e59e6eb5631423d987668c8064a54db272fdaea6344701e8245203296e60"
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
