FROM caddy:2.3.0-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare

FROM alpine:3.7

ENV TZ=Asia/Shanghai XDG_CONFIG_HOME=/config XDG_DATA_HOME=/data S6_VERSION=v2.2.0.3

LABEL maintainer "vyronfiee <vyronfiee@gmail.com>" caddy_version="${S6_VERSION}" 

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add --no-cache \
    ca-certificates \
    git \
    mailcap \
    openssh-client \
    tzdata \
    inotify-tools \
    curl && \ 
    curl -fSL https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-amd64.tar.gz | tar xz && \
    /usr/bin/caddy version && \
    /usr/bin/caddy list-modules && \
    echo 'Asia/Shanghai' >/etc/timezone 

EXPOSE 80 443 2019

VOLUME /srv

WORKDIR /srv

COPY Caddyfile /etc/caddy/Caddyfile

COPY index.html /srv/index.html


ENTRYPOINT ["/init"]