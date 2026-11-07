# qubes-symfony-dev-setup

Lightweight shell utility for **Qubes OS R4.2 / R4.3** development `AppVMs`.

In Qubes OS, an `AppVM` inherits a read-only root filesystem (`/`) from its parent `TemplateVM` (`debian-13-xfce` / `fedora-42-xfce`) and persists only `/rw` (`/home` and `/usr/local`) across reboots. When developing containerized **Symfony / PHP** applications inside an isolated development `AppVM`, Docker images, volumes, and daemon configurations stored in `/var/lib/docker` and `/etc/docker` are wiped on every VM restart unless explicitly mapped into `/rw/bind-dirs`.

This script configures `/rw/config/qubes-bind-dirs.d/50_symfony_docker_dev.conf` and `/rw/config/rc.local` so that `/var/lib/docker` and `/etc/docker` survive `AppVM` reboots without polluting the shared `TemplateVM`.

## Usage (Run inside your development `AppVM`, never in `dom0`)

```bash
chmod +x setup-qubes-dev-persistence.sh
./setup-qubes-dev-persistence.sh
```

After running once, restart the `AppVM` so Qubes mounts the persistent `bind-dirs` overlays cleanly.

## License

MIT License

