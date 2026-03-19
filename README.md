<p align="center">
  <img src="https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white" alt="Docker Compose">
  <img src="https://img.shields.io/badge/WordPress-latest-21759B?logo=wordpress&logoColor=white" alt="WordPress">
  <img src="https://img.shields.io/badge/PHP--FPM-8.3-777BB4?logo=php&logoColor=white" alt="PHP-FPM">
  <img src="https://img.shields.io/badge/Nginx-stable-009639?logo=nginx&logoColor=white" alt="Nginx">
  <img src="https://img.shields.io/badge/MariaDB-11-003545?logo=mariadb&logoColor=white" alt="MariaDB">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
</p>

# 🪺 OwlNest

**The testing nest for all OwlStack WordPress plugins.**

A Docker Compose environment purpose-built for testing [OwlStack](https://github.com/owlstack) WordPress plugins. Uses a production-grade stack with PHP-FPM, Nginx, and MariaDB. Spin up a fresh WordPress instance in one command, install your plugins, and start testing.

---

## What's Inside the Nest

| Service | Port | Description |
|---|---|---|
| **PHP-FPM 8.3** | `9000` (internal) | WordPress running on PHP-FPM with WP-CLI |
| **Nginx** | `8080` | Reverse proxy serving WordPress |
| **MariaDB 11** | `3306` (internal) | Database with health checks |
| **phpMyAdmin** | `8081` | Visual database management |

## Quick Start

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### 1. Clone the repository

```bash
git clone https://github.com/owlstack/owlnest.git
cd owlnest
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` to customize ports, versions, or credentials (defaults work out of the box).

### 3. Start the nest

```bash
docker compose up -d
```

### 4. Open WordPress

Visit [http://localhost:8080](http://localhost:8080) and complete the installation wizard.

### 5. Install OwlStack plugins

Once WordPress is running, install any OwlStack WordPress plugin via the admin dashboard (**Plugins → Add New → Upload Plugin**) or by copying plugin files into the container:

```bash
docker compose cp /path/to/owlstack-plugin php:/var/www/html/wp-content/plugins/
```

Then activate the plugin from the WordPress admin panel.

Need to manage the database? Open [http://localhost:8081](http://localhost:8081) for phpMyAdmin.

## Configuration

All settings are controlled via the `.env` file:

| Variable | Default | Description |
|---|---|---|
| `WORDPRESS_PORT` | `8080` | Host port for WordPress |
| `NGINX_VERSION` | `stable-alpine` | Nginx Docker image tag |
| `MARIADB_VERSION` | `11` | MariaDB Docker image tag |
| `DB_NAME` | `wordpress` | Database name |
| `DB_USER` | `wordpress` | Database user |
| `DB_PASSWORD` | `wordpress` | Database password |
| `DB_ROOT_PASSWORD` | `rootpassword` | MariaDB root password |
| `PHPMYADMIN_VERSION` | `latest` | phpMyAdmin Docker image tag |
| `PHPMYADMIN_PORT` | `8081` | Host port for phpMyAdmin |

> **Note:** Change the default passwords before using in any non-local environment.

## Common Commands

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# Stop and remove all data (fresh start)
docker compose down -v

# View logs
docker compose logs -f

# View logs for a specific service
docker compose logs -f php
docker compose logs -f nginx

# Restart a service
docker compose restart php

# Access PHP container shell
docker compose exec php sh

# Use WP-CLI
docker compose exec php wp --allow-root plugin list

# Access MariaDB CLI
docker compose exec db mariadb -u wordpress -p wordpress

# Copy a plugin into the WordPress container
docker compose cp ./my-plugin php:/var/www/html/wp-content/plugins/
```

## Testing Workflow

1. Start the environment with `docker compose up -d`
2. Complete the WordPress setup wizard at `http://localhost:8080`
3. Install the OwlStack plugin you want to test
4. Run your tests, verify behavior, check logs
5. Reset to a clean state anytime with `docker compose down -v && docker compose up -d`

## Data Persistence

WordPress files and MariaDB data are stored in Docker named volumes (`wordpress_data` and `db_data`). Your data persists across restarts. To completely reset for a fresh test:

```bash
docker compose down -v
```

## Related OwlStack Projects

- [owlstack-wordpress](https://github.com/owlstack/owlstack-wordpress) — OwlStack WordPress plugin
- [owlstack-core](https://github.com/owlstack/owlstack-core) — OwlStack PHP core library
- [owlstack-laravel](https://github.com/owlstack/owlstack-laravel) — OwlStack Laravel package

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the [MIT License](LICENSE).
