# Docker image for sb-nginx

[![](https://images.microbadger.com/badges/image/bohan/sb-nginx:1.17.2.svg)](https://hub.docker.com/r/bohan/sb-nginx)

## What's sb-nginx?

[sb-nginx](https://mirrors.xtom.com/sb/nginx/) is a Debian package by [SB Professional Services](https://www.sb/) / [xTom](https://xtom.com/) offering a nginx build supports:

 * Brotli compression
 * OpenSSL 1.1.1 with TLS 1.3 support
 * GeoIP2

## **Awesome** Usage

Put your config files (`nginx.conf` etc.) inside a folder, for example: `~/nginx-config`.

Then `run` the container:

    docker run --name nginx --net host --restart always -v $HOME/nginx-config:/usr/src/docker-nginx/conf:ro -d bohan/sb-nginx:1.17.2

You **must** mount the config dir to this specific `/usr/src/docker-nginx/conf` path!

Your existing config files will **replace** default config files.

### Reload Changed Configuration

You can even change your configuration after the container start and apply them without any downtime.

After change, run the command:

    docker exec nginx docker-nginx-reload.sh

This `docker-nginx-reload.sh` script will test your new configuration and reload the server. It will rollback if the test fails.
