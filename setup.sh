#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}WordPress Plugin Development Environment Setup${NC}"
echo -e "${BLUE}=========================================${NC}"

# Function to create directory if it doesn't exist
create_dir_if_not_exists() {
    if [ ! -d "$1" ]; then
        echo -e "${YELLOW}Creating directory: $1${NC}"
        mkdir -p "$1"
    fi
}

# Function to copy example file if target doesn't exist
copy_example_file() {
    if [ -f "$1" ] && [ ! -f "$2" ]; then
        echo -e "${GREEN}Creating $2 from example file${NC}"
        cp "$1" "$2"
    elif [ ! -f "$1" ]; then
        echo -e "${RED}Error: Example file $1 not found${NC}"
        return 1
    else
        echo -e "${YELLOW}File $2 already exists, skipping${NC}"
    fi
}

# Function to setup an environment (dev or qa)
setup_environment() {
    local env_type=$1
    echo -e "\n${BLUE}Setting up $env_type environment...${NC}"
    
    # Create logs directory
    create_dir_if_not_exists "$env_type/logs"
    
    # Copy configuration files from examples
    copy_example_file "$env_type/.env-example" "$env_type/.env"
    copy_example_file "$env_type/wordpress.env-example" "$env_type/wordpress.env"
    copy_example_file "$env_type/xdebug.ini-example" "$env_type/xdebug.ini"
    
    # Ask for plugin path customization
    if [ -f "$env_type/.env" ]; then
        echo -e "\n${YELLOW}Do you want to customize the plugin path for $env_type environment? (y/n)${NC}"
        read -r customize_plugin
        
        if [[ $customize_plugin =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Enter the path to your plugin source directory:${NC}"
            read -r plugin_path
            
            echo -e "${YELLOW}Enter the destination plugin name in WordPress:${NC}"
            read -r plugin_name
            
            if [ -n "$plugin_path" ] && [ -n "$plugin_name" ]; then
                # Update .env file with user input
                sed -i "s|PLUGIN_SRC_PATH=.*|PLUGIN_SRC_PATH=$plugin_path|" "$env_type/.env"
                sed -i "s|PLUGIN_DEST_NAME=.*|PLUGIN_DEST_NAME=$plugin_name|" "$env_type/.env"
                echo -e "${GREEN}Plugin configuration updated in $env_type/.env${NC}"
            fi
        fi
    fi
    
    # Ask for database customization
    if [ -f "$env_type/wordpress.env" ]; then
        echo -e "\n${YELLOW}Do you want to customize database settings for $env_type environment? (y/n)${NC}"
        read -r customize_db
        
        if [[ $customize_db =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Enter database user (default: wordpress):${NC}"
            read -r db_user
            
            echo -e "${YELLOW}Enter database password:${NC}"
            read -r db_password
            
            echo -e "${YELLOW}Enter database name:${NC}"
            read -r db_name
            
            # Update wordpress.env file with user input
            if [ -n "$db_user" ]; then
                sed -i "s|WORDPRESS_DB_USER=.*|WORDPRESS_DB_USER=$db_user|" "$env_type/wordpress.env"
            fi
            
            if [ -n "$db_password" ]; then
                sed -i "s|WORDPRESS_DB_PASSWORD=.*|WORDPRESS_DB_PASSWORD=$db_password|" "$env_type/wordpress.env"
            fi
            
            if [ -n "$db_name" ]; then
                sed -i "s|WORDPRESS_DB_NAME=.*|WORDPRESS_DB_NAME=$db_name|" "$env_type/wordpress.env"
            fi
            
            echo -e "${GREEN}Database configuration updated in $env_type/wordpress.env${NC}"
        fi
    fi
    
    echo -e "${GREEN}$env_type environment setup completed!${NC}"
}

# Main setup process
echo -e "\n${YELLOW}Which environment(s) do you want to set up?${NC}"
echo "1) Development environment only"
echo "2) QA environment only"
echo "3) Both environments"
read -r choice

case $choice in
    1)
        setup_environment "dev"
        ;;
    2)
        setup_environment "qa"
        ;;
    3)
        setup_environment "dev"
        setup_environment "qa"
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

# Make start/stop scripts executable
chmod +x start-dev.sh stop-dev.sh start-qa.sh stop-qa.sh 2>/dev/null

echo -e "\n${BLUE}=========================================${NC}"
echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${BLUE}=========================================${NC}"
echo -e "\nYou can now start the environment(s) using:"
echo -e "  ${YELLOW}./start-dev.sh${NC} - For development environment"
echo -e "  ${YELLOW}./start-qa.sh${NC} - For QA environment"
echo -e "\nTo stop the environment(s):"
echo -e "  ${YELLOW}./stop-dev.sh${NC} - For development environment"
echo -e "  ${YELLOW}./stop-qa.sh${NC} - For QA environment"
