FROM debian:buster-slim

ARG VERSION="1.19.0"
ARG PACKAGE_REPO="https://mirrors.xtom.com/sb/nginx"

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates gettext-base busybox; \
    busybox wget -O /etc/apt/trusted.gpg.d/sb-nginx.asc "$PACKAGE_REPO/public.key"; \
    echo "deb $PACKAGE_REPO buster main" > /etc/apt/sources.list.d/sb-nginx.list; \
    printf "Package: nginx*\nPin: version $VERSION-1sb+*\nPin-Priority: 510\n" > /etc/apt/preferences.d/50nginx; \
    printf "Package: libnginx-*\nPin: version $VERSION-1sb+*\nPin-Priority: 510\n" > /etc/apt/preferences.d/50libnginx; \
    apt-get update; \
    apt-get install -y --no-install-recommends nginx; \
    apt-get purge -y --auto-remove busybox; \
    rm -rf /var/lib/apt/lists/*; \
    ln -sf /dev/stdout /var/log/nginx/access.log; \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY docker-nginx-*.sh docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
