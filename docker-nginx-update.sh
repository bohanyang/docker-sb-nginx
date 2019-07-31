#!/usr/bin/env sh

set -e

destdir="/etc/nginx"

# First Start: "/etc/nginx"
# Subsequent Updates: "/usr/src/docker-nginx/v0000000000000000000"
currdir="$(readlink -f $destdir)"

workdir="/usr/src/docker-nginx"
confdir="$workdir/conf"
defaults="$workdir/defaults"

# First Start: "/usr/src/docker-nginx/v0000000000000000000"
# Subsequent Updates: "/usr/src/docker-nginx/v1111111111111111111"
nextdir="$workdir/v$(date +%s%N)"

rm -rf "$nextdir"
mkdir "$nextdir"

mkdir -p "$confdir"
cp -R "$defaults"/* "$nextdir"
cp -R "$confdir"/* "$nextdir"
ln -sfn "$nextdir" "$destdir"

if nginx -t; then
  if [ "$currdir" != "$destdir" ]; then
    rm -rf "$currdir"
  fi
else
  if [ "$currdir" != "$destdir" ]; then
    ln -sfn "$currdir" "$destdir"
  fi
  rm -rf "$nextdir"
  exit 1
fi
