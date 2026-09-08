#!/bin/sh
set -eu
out=/out/licenses
mkdir -p "$out/go-modules" "$out/go-toolchain"
# Keep directory paths so identical filenames from different modules cannot collide.
cd /go/pkg/mod
find . -type f \( -iname 'license*' -o -iname 'notice*' -o -iname 'copying*' -o -iname 'copyright*' -o -iname 'authors*' \) \
  ! -path './cache/*' -exec sh -c '
    out=$1; shift
    for source do
      target="$out/${source#./}"
      mkdir -p "$(dirname "$target")"
      cp "$source" "$target"
    done
  ' sh "$out/go-modules" {} +
test -n "$(find "$out/go-modules" -type f -print -quit)"
cp /usr/local/go/LICENSE "$out/go-toolchain/LICENSE"
go version -m /usr/bin/caddy > "$out/build-info.txt"
