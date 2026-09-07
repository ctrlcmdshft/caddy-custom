#!/bin/bash
set -euo pipefail
umask 077
icon_source=${1:-}
if [ -z "$icon_source" ]; then
    icon_source=$(mktemp /tmp/caddy-icon.XXXXXX)
    trap 'rm -f "$icon_source"' EXIT
    curl --fail --silent --show-error --location \
      https://raw.githubusercontent.com/ctrlcmdshft/caddy-custom/main/assets/caddy-custom-mixed-icon.png \
      -o "$icon_source"
fi
template=/boot/config/plugins/dockerMan/templates-user/my-Caddy-Custom.xml
icon_dir=/boot/config/plugins/dockerMan/icons
icon_path="$icon_dir/caddy-custom.png"
test -f "$icon_source"
test -f "$template"
php -r '$i=getimagesize($argv[1]); if (!$i || $i[2] !== IMAGETYPE_PNG) {fwrite(STDERR,"Not a valid PNG\n"); exit(1);}' "$icon_source"
cp -p "$template" "$template.backup-icon-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$icon_dir"
cp "$icon_source" "$icon_path"
chmod 644 "$icon_path"
php <<'PHP'
<?php
$p='/boot/config/plugins/dockerMan/templates-user/my-Caddy-Custom.xml';
libxml_use_internal_errors(true);
$x=simplexml_load_file($p);
if (!$x || (string)$x->Name !== 'Caddy-Custom') {fwrite(STDERR,"Unexpected template; stopped.\n");exit(1);}
unset($x->Icon);
$x->addChild('Icon','https://raw.githubusercontent.com/ctrlcmdshft/caddy-custom/main/assets/caddy-custom-mixed-icon.png');
if ($x->asXML($p) === false) {fwrite(STDERR,"Template write failed. Restore icon backup.\n");exit(1);}
PHP
for cache in /var/lib/docker/unraid/images /usr/local/emhttp/state/plugins/dynamix.docker.manager/images; do
    mkdir -p "$cache"
    cp "$icon_path" "$cache/Caddy-Custom-icon.png"
    chmod 644 "$cache/Caddy-Custom-icon.png"
done
echo 'Icon installed. Refresh the Unraid Docker page. No container restarted.'
