cask "routengine" do
  version "1.2.2"
  sha256 "98b048268f1bb79f1b4284d5a468c46a1219253526e8f2422f7625cbb635f1b4"

  url "https://routengine.net/download/RoutEngine-#{version}.dmg"
  name "RoutEngine"
  desc "Choose which network adapter each app uses"
  homepage "https://routengine.net"

  livecheck do
    url "https://github.com/champdev-me/routengine/releases/latest"
    strategy :github_latest
  end

  depends_on macos: :ventura

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
