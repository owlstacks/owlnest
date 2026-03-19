#!/bin/sh
set -e

# Wait for the database to be ready
until php -r "new mysqli('${WORDPRESS_DB_HOST}', '${WORDPRESS_DB_USER}', '${WORDPRESS_DB_PASSWORD}', '${WORDPRESS_DB_NAME}');" 2>/dev/null; do
  echo "Waiting for database connection..."
  sleep 2
done

# Generate wp-config.php if it doesn't exist
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Generating wp-config.php..."
  wp config create \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --path=/var/www/html \
    --allow-root
  chown www-data:www-data /var/www/html/wp-config.php
fi

exec "$@"
