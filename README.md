# Homebrew tap for RoutEngine

[RoutEngine](https://routengine.net) chooses which network adapter each app uses, with failover, speed limits and data caps.

```
brew install champdev-me/tap/routengine           # command line, macOS and Linux
brew install --cask champdev-me/tap/routengine    # the macOS app (window and menu-bar icon)
```

The command-line program needs root to create its virtual adapter: `sudo routengine run`. The app asks for your password once per launch. The app is not notarized by Apple, so the cask clears the download quarantine flag after installing it.

Both follow the latest [release](https://github.com/champdev-me/routengine/releases/latest) by themselves: the `update` workflow checks every three hours.

Docs: https://github.com/champdev-me/routengine
