#!/usr/bin/env bash
# qubes-symfony-dev-setup: Configures /rw/config/qubes-bind-dirs.d/ and rc.local
# inside a Qubes OS R4.2 / R4.3 development AppVM so Docker & Symfony CLI configs persist across reboots.
set -euo pipefail

BIND_CONF_DIR="/rw/config/qubes-bind-dirs.d"
BIND_CONF_FILE="${BIND_CONF_DIR}/50_symfony_docker_dev.conf"
RC_LOCAL="/rw/config/rc.local"

echo "[+] Configuring persistent bind-dirs in ${BIND_CONF_FILE}..."
sudo mkdir -p "${BIND_CONF_DIR}" "/rw/bind-dirs/var/lib/docker" "/rw/bind-dirs/etc/docker"

cat << 'EOF' | sudo tee "${BIND_CONF_FILE}" > /dev/null
binds+=( '/var/lib/docker' )
binds+=( '/etc/docker' )
EOF

if ! grep -q "systemctl restart docker" "${RC_LOCAL}" 2>/dev/null; then
    echo "systemctl restart docker || true" | sudo tee -a "${RC_LOCAL}" > /dev/null
    sudo chmod +x "${RC_LOCAL}"
fi
echo "[✓] Qubes AppVM persistence configured. Reboot AppVM to activate bind-dirs."

