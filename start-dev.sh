#!/bin/bash

# Start the development environment
cd "$(dirname "$0")/dev"
echo "Starting WordPress development environment with MCP server..."
docker-compose up -d

echo ""
echo "WordPress development environment is running!"
echo "Access WordPress at: http://localhost:8080"
echo "Admin area: http://localhost:8080/wp-admin/"
echo ""
echo "Default credentials (first time setup):"
echo "Username: admin"
echo "Password: password"
echo ""
echo "To stop the environment: ./stop-dev.sh"
