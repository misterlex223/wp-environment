#!/bin/bash

# Stop the development environment
cd "$(dirname "$0")/dev"
echo "Stopping WordPress development environment..."
docker-compose down

echo "Development environment stopped."
