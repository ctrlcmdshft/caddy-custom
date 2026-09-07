# Custom Caddy image

![Caddy Custom icon](assets/caddy-custom-mixed-icon.png)

Caddy with the Porkbun DNS provider and caddy-docker-proxy, compiled during image
build rather than container startup. Initial target: Linux amd64.

This repository contains build instructions only. Supply the Caddyfile, DNS
credentials, certificate storage, timezone and Docker network attachments at
runtime. No production configuration is included.

## Initial candidate build

Set repository variables DOCKERHUB_USERNAME and DOCKERHUB_IMAGE (account/image).
Store a Docker Hub publishing token as the Actions secret DOCKERHUB_TOKEN.
Never put the token into a file, workflow input, or commit. No Porkbun secrets
are needed in GitHub. The Docker Hub image visibility is configured separately
from GitHub repository visibility.

Run Build candidate in Actions with the exact Caddy and plugin versions from
the existing installation. The workflow checks the compiled version and modules,
then publishes candidate and a unique build tag. These checks do not test live
TLS, DNS issuance, or application routing. Test those on an isolated container.

The candidate workflow never updates stable. Use the separate Promote tested image
to stable workflow with an exact tested build tag to promote without rebuilding.
The workflow verifies that the pulled stable image has the same image ID.
Unraid can track stable while installation remains user-controlled.
Automated upstream version proposals are still pending; builds currently use
manually supplied versions. No workflow directly changes the running server.

The container expects /etc/caddy/Caddyfile and uses /etc/caddy/data and
/etc/caddy/config as XDG storage roots. Its default ingress network is caddy-proxy;
override the command for other deployments.

## Privacy

The build context allows only Dockerfile. Git ignores all files except the
explicit build-file allowlist. These are safeguards, not protection against
deliberate force-adds or later workflow changes. Review changes before publishing.
Public repositories expose account names, commit metadata and workflow logs.
Public images expose image names, layers and image configuration. Keep all
runtime secrets and server-specific configuration outside this repository.


## Unraid icon

The custom illustration combines a blue container whale, green HTTPS lock and
orange server bays. It is an unofficial illustration, not an official combined
product logo. The original PNG is saved in assets/caddy-custom-mixed-icon.png.

The public template references the PNG directly from GitHub. To update an existing
Caddy-Custom container's local template and icon cache, download and run the installer:

```bash
curl -fL https://raw.githubusercontent.com/ctrlcmdshft/caddy-custom/main/unraid/install-icon.sh -o /tmp/caddy-install-icon.sh
bash /tmp/caddy-install-icon.sh
```

The installer downloads the PNG, backs up the populated local template, changes
only its Icon field, and refreshes the icon caches. It does not restart Caddy or
print credentials. Refresh the Unraid Docker page afterward. The local template
and its backup contain credentials and must remain on your server.
