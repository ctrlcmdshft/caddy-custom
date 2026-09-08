ARG CADDY_VERSION=2.11.4
FROM caddy:${CADDY_VERSION}-builder AS builder
ARG CADDY_VERSION
ARG PORKBUN_VERSION
ARG DOCKER_PROXY_VERSION
ENV XCADDY_SKIP_CLEANUP=1
RUN test -n "$PORKBUN_VERSION" && test -n "$DOCKER_PROXY_VERSION" \
    && xcaddy build "v${CADDY_VERSION}" --output /usr/bin/caddy \
       --with "github.com/caddy-dns/porkbun@${PORKBUN_VERSION}" \
       --with "github.com/lucaslorentz/caddy-docker-proxy/v2@${DOCKER_PROXY_VERSION}"

COPY scripts/collect-notices.sh /tmp/collect-notices.sh
RUN sh /tmp/collect-notices.sh

FROM caddy:${CADDY_VERSION}-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY --from=builder /out/licenses/ /usr/share/licenses/caddy-custom/
COPY LICENSE THIRD_PARTY_NOTICES.md /usr/share/licenses/caddy-custom/project/
COPY licenses/ /usr/share/licenses/caddy-custom/upstream/
ENV XDG_DATA_HOME=/etc/caddy/data \
    XDG_CONFIG_HOME=/etc/caddy/config
ENTRYPOINT ["/usr/bin/caddy"]
CMD ["docker-proxy", "--caddyfile-path", "/etc/caddy/Caddyfile", "--ingress-networks", "caddy-proxy"]
