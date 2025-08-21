#!/bin/bash

# Start the development environment
cd "$(dirname "$0")/dev"

# Check if rebuild parameter is provided
REBUILD=""
if [ "$1" == "--rebuild" ] || [ "$1" == "-r" ]; then
    REBUILD="--build"
    echo "Starting WordPress development environment with MCP server (rebuilding images)..."
else
    echo "Starting WordPress development environment with MCP server..."
    echo "(Use --rebuild or -r parameter to rebuild Docker images)"
fi

docker compose up -d $REBUILD

echo ""
echo "WordPress development environment is running!"
echo "Access WordPress at: http://localhost:8080"
echo "Admin area: http://localhost:8080/wp-admin/"
echo "phpMyAdmin: http://localhost:8181"
echo ""
echo "Default credentials (first time setup):"
echo "Username: admin"
echo "Password: admin"
echo ""

echo "To stop the environment: ./stop-dev.sh"
