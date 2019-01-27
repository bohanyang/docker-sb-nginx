#!/bin/sh

set -e

docker-nginx-update.sh

openresty -s reload
