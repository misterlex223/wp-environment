FROM wordpress:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

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
RUN echo "define('WPMCP_JWT_SECRET_KEY', 'dev-secret-key');" >> /var/www/html/wp-config.php && \
    echo "define('WPMCP_DEBUG', true);" >> /var/www/html/wp-config.php