#!/bin/bash

# Start the QA environment
cd "$(dirname "$0")/qa"

# Check if rebuild parameter is provided
REBUILD=""
if [ "$1" == "--rebuild" ] || [ "$1" == "-r" ]; then
    REBUILD="--build"
    echo "Starting WordPress QA environment with MCP server (rebuilding images)..."
else
    echo "Starting WordPress QA environment with MCP server..."
    echo "(Use --rebuild or -r parameter to rebuild Docker images)"
fi

docker compose up -d $REBUILD

echo ""
echo "WordPress QA environment is running!"
echo "Access WordPress at: http://localhost:8081"
echo "Admin area: http://localhost:8081/wp-admin/"
echo "phpMyAdmin: http://localhost:8182"
echo ""
echo "Default credentials (first time setup):"
echo "Username: admin"
echo "Password: admin"
echo ""

echo "To stop the environment: ./stop-qa.sh"
