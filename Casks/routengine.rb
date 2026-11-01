cask "routengine" do
  version "1.2.1"
  sha256 "6091d8a7b4da56e222e5d21d8762c471691f3ba03e3dac0f594be322a412944b"

  url "https://routengine.net/download/RoutEngine-#{version}.dmg"
  name "RoutEngine"
  desc "Choose which network adapter each app uses"
  homepage "https://routengine.net"

  livecheck do
    url "https://github.com/champdev-me/routengine/releases/latest"
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "RoutEngine.app"

  # The app is not notarized by Apple (no Developer ID), so macOS would block its first start.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/RoutEngine.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/routengine",
    "~/Library/Caches/routengine",
  ]

  caveats <<~EOS
    RoutEngine asks for your password once per launch, to create its virtual network adapter.
  EOS
end
