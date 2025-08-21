# WordPress Plugin Development Environment

This repository contains Docker configurations for WordPress plugin development with integrated WordPress MCP (Model Context Protocol) server. The setup includes both development and QA environments with a unified environment variable structure.

## Environment Structure

```
environment/
├── dev/                    # Development environment
│   ├── Dockerfile          # WordPress with MCP and development tools
│   ├── docker-compose.yml  # Docker Compose configuration with WordPress, MySQL, and phpMyAdmin
│   ├── wordpress-setup.sh  # Automatic WordPress installation script
│   ├── generate-jwt.sh     # Script to generate JWT tokens for admin user
│   ├── .env                # Environment variables (copy from .env-example)
│   ├── .env-example        # Example environment variables
│   └── xdebug.ini          # Xdebug configuration for development
├── qa/                     # QA environment
│   ├── Dockerfile          # WordPress with MCP for QA testing
│   ├── docker-compose.yml  # Docker Compose configuration for QA
│   ├── wordpress-setup.sh  # Automatic WordPress installation script
│   ├── generate-jwt.sh     # Script to generate JWT tokens for admin user
│   ├── .env                # Environment variables (copy from .env-example)
│   ├── .env-example        # Example environment variables
│   └── xdebug.ini          # Minimal Xdebug configuration for QA
├── setup.sh                # Environment setup script
├── start-dev.sh            # Start development environment
├── stop-dev.sh             # Stop development environment
├── start-qa.sh             # Start QA environment
└── stop-qa.sh              # Stop QA environment
```

## Development Environment

The development environment is configured for active plugin development with:

- WordPress with latest version
- WordPress MCP server for AI development workflows
- MySQL 5.7 database
- phpMyAdmin for database management
- Automatic WordPress setup (no installation wizard)
- Xdebug enabled for debugging
- Git, Composer, and Node.js for development workflows
- WP-CLI for WordPress management

### Usage

```bash
cd environments/dev
docker-compose up -d
```

Access the WordPress site at http://localhost:8080
Access phpMyAdmin at http://localhost:8181

## QA Environment

The QA environment is configured for testing with:

- WordPress with latest version
- WordPress MCP server with debugging disabled
- MySQL 5.7 database
- phpMyAdmin for database management
- Automatic WordPress setup (no installation wizard)
- Xdebug disabled for production-like testing
- Separate network and volume configuration from development
- WP-CLI for WordPress management

### Usage

```bash
cd environments/qa
docker-compose up -d
```

Access the QA WordPress site at http://localhost:8081
Access phpMyAdmin at http://localhost:8182

## WordPress MCP Server

The WordPress MCP (Model Context Protocol) server is installed in both environments to facilitate AI-assisted development workflows. It provides:

- Integration with AI development tools
- JWT authentication for secure API access
- Debug logging (enabled in dev, disabled in QA)

### MCP Configuration

The MCP server is configured with:

- Dev environment: `WPMCP_DEBUG=true` for detailed logging
- QA environment: `WPMCP_DEBUG=false` for production-like behavior

### JWT Authentication

Both environments automatically generate JWT tokens for the admin user during setup:

- Tokens are valid for 30 days
- Tokens are displayed in the console when starting the environment
- Tokens can be used for authenticated API requests to the MCP server

To manually generate a new JWT token:

```bash
# For development environment
docker exec -it wp-wordpress /usr/local/bin/generate-jwt.sh

# For QA environment
docker exec -it wp-qa-wordpress /usr/local/bin/generate-jwt.sh
```

## Automatic WordPress Setup

Both environments include an automatic WordPress setup feature that eliminates the need to go through the WordPress installation wizard:

- WordPress is automatically installed with the settings defined in your `.env` file
- The setup script uses WP-CLI to configure WordPress during container startup
- If WordPress is already installed, the setup is skipped

### Configuration Options

You can customize the WordPress installation by setting these variables in your `.env` file:

- `WORDPRESS_TITLE` - The title of your WordPress site
- `WORDPRESS_ADMIN_USER` - Admin username
- `WORDPRESS_ADMIN_PASSWORD` - Admin password
- `WORDPRESS_ADMIN_EMAIL` - Admin email address
- `WORDPRESS_LOCALE` - Site language (e.g., en_US, zh_TW)

### Database Management

Each environment includes phpMyAdmin for easy database management:

- Development environment: http://localhost:8181
- QA environment: http://localhost:8182

Use the database credentials from your `.env` file to log in.

## Plugin Development

To develop a WordPress plugin:

1. Place your plugin code in the appropriate directory structure
2. Mount your plugin directory to the WordPress container using the `PLUGIN_SRC_PATH` in `.env`
3. Activate the plugin through the WordPress admin interface

## Environment Variables

The environment uses a unified `.env` file that contains all necessary configurations for both Docker Compose and WordPress. This ensures consistency between the WordPress application and its database.

### `.env` File Structure

```
# Plugin Configuration
PLUGIN_SRC_PATH=../../sync-fire-wp  # Path to your plugin source code
PLUGIN_DEST_NAME=sync-fire          # Destination folder name in WordPress

# Database Configuration
WORDPRESS_DB_HOST=db
WORDPRESS_DB_USER=wordpress
WORDPRESS_DB_PASSWORD=wordpress
WORDPRESS_DB_NAME=wordpress

# WordPress Configuration
WORDPRESS_DEBUG=1
WORDPRESS_CONFIG_EXTRA="define('WP_DEBUG_LOG', true); define('WP_DEBUG_DISPLAY', false);"

# WordPress Initial Setup Configuration
WORDPRESS_TITLE="WordPress Development Site"
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASSWORD=admin
WORDPRESS_ADMIN_EMAIL=admin@example.com
WORDPRESS_LOCALE=en_US
```

### Using the Environment Variables

1. Copy the example file to create your `.env` file:
   ```bash
   cd environment/dev  # or environment/qa
   cp .env-example .env
   ```

2. Modify the values in `.env` as needed for your setup.

3. The variables are used by both Docker Compose and the WordPress container, ensuring consistent configuration across the entire stack.

### Security Note

- The `.env` file contains sensitive information and should not be committed to version control.
- The `.env-example` file is provided as a template and should not contain real credentials.
- Make sure to add `.env` to your `.gitignore` file.
- It keeps Docker Compose configuration separate from application configuration
- It provides better organization of environment variables
- It allows for different handling of different types of variables

## GitHub Integration

This environment setup can be used as a template for WordPress plugin development with AI automation workflows. To use with GitHub:

1. Initialize a Git repository in this directory
2. Push to GitHub
3. Configure GitHub Actions for CI/CD if needed

## Customization

You can customize these environments by:

- Modifying the Dockerfile to include additional tools
- Updating docker-compose.yml to add services
- Adjusting environment variables in .env
- Configuring Xdebug settings in xdebug.ini
