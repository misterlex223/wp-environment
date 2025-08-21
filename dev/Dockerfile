FROM wordpress:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install PHP extensions
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install WordPress MCP
RUN cd /var/www/html/wp-content/plugins && \
    git clone https://github.com/Automattic/wordpress-mcp.git && \
    cd wordpress-mcp && \
    composer install --no-dev && \
    npm install && npm run build

# Configure WordPress MCP
RUN echo "define('WPMCP_JWT_SECRET_KEY', 'dev-secret-key');" >> /var/www/html/wp-config-sample.php && \
    echo "define('WPMCP_DEBUG', true);" >> /var/www/html/wp-config-sample.php

# Copy custom WordPress setup script
COPY wordpress-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-setup.sh

# Use default WordPress entrypoint and run our setup script
COPY docker-entrypoint-wrapper.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint-wrapper.sh
ENTRYPOINT ["docker-entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]