#!/bin/bash

# Start the QA environment
cd "$(dirname "$0")/qa"
echo "Starting WordPress QA environment with MCP server..."
docker compose up -d

echo ""
echo "WordPress QA environment is running!"
echo "Access WordPress at: http://localhost:8081"
echo "Admin area: http://localhost:8081/wp-admin/"
echo ""
echo "To stop the environment: ./stop-qa.sh"
