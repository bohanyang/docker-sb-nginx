#!/bin/sh

set -e

destdir="/etc/nginx"
workdir="/usr/src/docker-nginx"
defaults="$workdir/defaults"
cachedir="/var/cache/nginx"

mkdir -p "$workdir" "$cachedir"
mv "$destdir" "$defaults"
chown -R www-data:www-data "$cachedir"
chmod -R o-rwx "$cachedir"

docker-nginx-update.sh

exec "$@"
