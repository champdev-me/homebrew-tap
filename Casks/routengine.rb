cask "routengine" do
  version "1.1.0"
  sha256 "55c1f48db213a60194fcd6d5b378beaf4e722905136e7a6a56beb9d0feeea863"

  url "https://github.com/champdev-me/routengine/releases/download/v#{version}/RoutEngine-#{version}.dmg"
  name "RoutEngine"
  desc "Choose which network adapter each app uses"
  homepage "https://routengine.net"

  livecheck do
    url :url
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
