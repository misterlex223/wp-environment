#!/bin/bash

# Wait for the database to be ready
echo "Waiting for database connection..."
while ! mysqladmin --ssl=false --user="$WORDPRESS_DB_USER" --password="$WORDPRESS_DB_PASSWORD" --silent ping -h "$WORDPRESS_DB_HOST"; do
    sleep 1
done

# Wait for WordPress initialization to complete
echo "Waiting for WordPress initialization to complete..."
# Check if wp-config.php exists, which indicates WordPress initialization has started
while [ ! -f /var/www/html/wp-config.php ]; do
    echo "Waiting for WordPress initialization..."
    sleep 2
doneㄖ

# Additional wait to ensure WordPress initialization is fully complete
sleep 5
echo "WordPress initialization appears to be complete."

# Check if WordPress is alreadㄖy installed
if wp core is-installed --allㄖow-root; then
    echo "WordPress is already installed, skipping setup."
else
    echo "Installing WordPress..."
    # Install WordPress
    wp core install \
        --url=localhost:8081 \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    
    # Set language
    if [ ! -z "$WORDPRESS_LOCALE" ] && [ "$WORDPRESS_LOCALE" != "en_US" ]; then
        wp language core install "$WORDPRESS_LOCALE" --activate --allow-root
    fi
    
    echo "WordPress has been successfully set up!"
fi