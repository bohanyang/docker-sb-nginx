FROM debian:buster-slim

ARG VERSION="1.19.9-1sb+111k+buster1"
ARG PACKAGE_REPO="https://mirror-cdn.xtom.com/sb/nginx"

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates gettext-base wget; \
    wget -O /etc/apt/trusted.gpg.d/sb-nginx.asc "$PACKAGE_REPO/public.key"; \
    echo "deb $PACKAGE_REPO buster main" > /etc/apt/sources.list.d/sb-nginx.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends "nginx=$VERSION"; \
    apt-get purge -y --auto-remove wget; \
    rm -rf /var/lib/apt/lists/*; \
    ln -sf /dev/stdout /var/log/nginx/access.log; \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY docker-nginx-*.sh docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
