cask "routengine" do
  version "1.2.3"
  sha256 "46b81fd0222189bd3110e5228656c311bbdd07e3f40ee3ae346929852e9eb941"

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

  # Start at sign-in (Settings) adds a login item, a root-owned copy of the app and a sudoers rule for that copy.
  uninstall launchctl: "net.routengine.app",
            delete:    [
              "/etc/sudoers.d/routengine-app",
              "/Library/RoutEngine",
            ]

  zap trash: [
    "~/Library/Application Support/routengine",
    "~/Library/Caches/routengine",
  ]

  caveats <<~EOS
    RoutEngine asks for your password once per launch, to create its virtual network adapter,
    unless Start at sign-in is ticked in its Settings.
  EOS
end
