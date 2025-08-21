# WordPress Plugin Development Environments

This repository contains Docker configurations for WordPress plugin development with integrated WordPress MCP (Model Context Protocol) server. The setup includes both development and QA environments.

## Environment Structure

```
environments/
├── dev/                    # Development environment
│   ├── Dockerfile          # WordPress with MCP and development tools
│   ├── docker-compose.yml  # Docker Compose configuration with WordPress and MySQL
│   ├── .env                # Environment variables for Docker Compose
│   ├── wordpress.env       # WordPress environment variables
│   └── xdebug.ini          # Xdebug configuration for development
├── qa/                     # QA environment
│   ├── Dockerfile          # WordPress with MCP for QA testing
│   ├── docker-compose.yml  # Docker Compose configuration for QA
│   ├── .env                # Environment variables for Docker Compose
│   ├── wordpress.env       # WordPress environment variables for QA
│   └── xdebug.ini          # Minimal Xdebug configuration for QA
└── README.md               # This documentation file
```

## Development Environment

The development environment is configured for active plugin development with:

- WordPress with latest version
- WordPress MCP server for AI development workflows
- MySQL 5.7 database
- Xdebug enabled for debugging
- Git, Composer, and Node.js for development workflows

### Usage

```bash
cd environments/dev
docker-compose up -d
```

Access the WordPress site at http://localhost:8080

## QA Environment

The QA environment is configured for testing with:

- WordPress with latest version
- WordPress MCP server with debugging disabled
- MySQL 5.7 database
- Xdebug disabled for production-like testing
- Separate network and volume configuration from development

### Usage

```bash
cd environments/qa
docker-compose up -d
```

Access the QA WordPress site at http://localhost:8081

## WordPress MCP Server

The WordPress MCP (Model Context Protocol) server is installed in both environments to facilitate AI-assisted development workflows. It provides:

- Integration with AI development tools
- JWT authentication for secure API access
- Debug logging (enabled in dev, disabled in QA)

### MCP Configuration

The MCP server is configured with:

- Dev environment: `WPMCP_DEBUG=true` for detailed logging
- QA environment: `WPMCP_DEBUG=false` for production-like behavior

## Plugin Development

To develop a WordPress plugin:

1. Place your plugin code in the appropriate directory structure
2. Mount your plugin directory to the WordPress container
3. Activate the plugin through the WordPress admin interface

## Environment Variables

The environments use two different types of environment variable files, each serving a distinct purpose:

### 1. `.env` File (Docker Compose Variables)

The `.env` file contains variables used by Docker Compose itself for configuration:

- `PLUGIN_SRC_PATH`: The source path to your WordPress plugin directory
- `PLUGIN_DEST_NAME`: The destination folder name in the WordPress plugins directory

These variables are used for Docker Compose configuration like volume mounts and are NOT automatically passed into containers. You can override them when running docker-compose:

```bash
# Example: Using a different plugin source path
export PLUGIN_SRC_PATH=/path/to/your/custom-plugin
export PLUGIN_DEST_NAME=custom-plugin
docker-compose up -d
```

### 2. `wordpress.env` File (Container Variables)

The `wordpress.env` file contains variables that are passed directly into the WordPress container:

- `WORDPRESS_DB_HOST`: Database host (typically "db")
- `WORDPRESS_DB_USER`: Database user
- `WORDPRESS_DB_PASSWORD`: Database password
- `WORDPRESS_DB_NAME`: Database name
- `WORDPRESS_DEBUG`: Enable/disable WordPress debug mode
- Other WordPress-specific configuration

These variables configure the WordPress application inside the container.

### Why Two Different Files?

This separation is a best practice because:
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
- Adjusting environment variables in wordpress.env
- Configuring Xdebug settings in xdebug.ini
