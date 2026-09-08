# Licensing and attribution

The MIT license in this repository applies to its original build configuration,
workflows, scripts and documentation. It does not relicense upstream software,
third-party artwork or trademarks.

| Component | License | Attribution and source |
| --- | --- | --- |
| Caddy | Apache-2.0 | Caddy authors; https://github.com/caddyserver/caddy |
| Porkbun DNS plugin | MIT | Copyright (c) 2022 Niall Fitzpatrick; https://github.com/caddy-dns/porkbun |
| caddy-docker-proxy | MIT | Copyright (c) 2018 Lucas Lorentz Lara; https://github.com/lucaslorentz/caddy-docker-proxy |

Exact license texts for the initial component versions are in `licenses/`.
The Dockerfile is a custom adaptation of the build approach documented by Caddy
and caddy-docker-proxy. It changes module selection, storage defaults, startup
command and notice packaging; it is not an official upstream distribution.

Future builds collect license/copyright/notice files from downloaded Go modules,
record binary build information, and include the Go toolchain license at
`/usr/share/licenses/caddy-custom/`. This collection is attribution support,
not a legal certification or a replacement for reviewing newly added licenses.
Previously published image tags are not changed by a repository edit.

The final image also contains software inherited from the official Caddy Alpine
base image. Those packages retain their own licenses, including any applicable
source-distribution obligations. Base sources and package/license records:

- https://github.com/caddyserver/caddy-docker
- https://pkgs.alpinelinux.org/packages
- https://gitlab.alpinelinux.org/alpine/aports
- https://dl-cdn.alpinelinux.org/alpine/

Docker, Caddy, Porkbun and Unraid names identify compatibility or dependencies.
This project is independent and is not endorsed by those projects or companies.
No trademark rights are granted by this repository's license. Unraid itself and
Docker Engine are not bundled in this custom image.

Artwork is AI-generated and may receive local background/layout edits. Permission
to reuse original project artwork is granted under the repository's MIT terms to
the extent rights exist; this is not a claim of exclusive rights in AI output or
permission to use third-party trademarks. Earlier whale artwork is retired and
excluded from this grant; historical Git revisions may still contain it.
