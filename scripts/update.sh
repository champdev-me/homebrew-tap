#!/usr/bin/env bash
# Rewrites Formula/routengine.rb and Casks/routengine.rb from the latest RoutEngine release (version and the
# SHA-256 of each file, taken from the GitHub release assets). Leaves both alone if an asset is missing.
set -euo pipefail
cd "$(dirname "$0")/.."
rel=$(gh api repos/champdev-me/routengine/releases/latest)
tag=$(jq -r .tag_name <<<"$rel"); v=${tag#v}
sha() { jq -r --arg n "$1" '.assets[] | select(.name == $n) | .digest | sub("sha256:"; "")' <<<"$rel"; }
m=$(sha "routengine-$v-mac.tar.gz"); x=$(sha "routengine-$v-linux-amd64.tar.gz"); a=$(sha "routengine-$v-linux-arm64.tar.gz"); d=$(sha "RoutEngine-$v.dmg")
for s in "$m" "$x" "$a" "$d"; do
    [ -n "$s" ] || { echo "release $tag has no complete set of files yet; leaving the formula and cask alone"; exit 0; }
done
sed -e "s/@VERSION@/$v/g" -e "s/@SHA_MACOS@/$m/" -e "s/@SHA_LINUX_AMD64@/$x/" -e "s/@SHA_LINUX_ARM64@/$a/" formula.rb.in > Formula/routengine.rb
sed -e "s/@VERSION@/$v/g" -e "s/@SHA_DMG@/$d/" cask.rb.in > Casks/routengine.rb
echo "formula and cask are at $v"
