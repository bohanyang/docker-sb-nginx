#!/bin/sh

set -e

destdir="/etc/nginx"
currdir="$(readlink -f $destdir)"
workdir="/usr/src/docker-nginx"
confdir="$workdir/conf"
defaults="$workdir/defaults"
nextdir="$workdir/v$(date +%s%N)"

mkdir "$nextdir"
mkdir -p "$confdir"
cp -R "$defaults/." "$nextdir"
cp -R "$confdir/." "$nextdir"
rm -rf "$nextdir/.git" "$nextdir/.vscode"
ln -sfn "$nextdir" "$destdir"

if ! nginx -t; then
  ln -sfn "$currdir" "$destdir"
  exit 1
fi
