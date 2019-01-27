#!/bin/sh

set -e

docker-nginx-update.sh

nginx -s reload
