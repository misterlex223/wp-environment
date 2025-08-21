#!/bin/bash

# Stop the development environment
cd "$(dirname "$0")/dev"

# Check if release-volumes parameter is provided
VOLUME_FLAG=""
if [ "$1" == "--release-volumes" ] || [ "$1" == "-r" ]; then
    VOLUME_FLAG="--volumes"
    echo "Stopping WordPress development environment (release volumes)..."
else
    echo "Stopping WordPress development environment (removing volumes)..."
    echo "(Use --release-volumes or -r parameter to release volumes)"
fi

docker compose down $VOLUME_FLAG

echo "Development environment stopped."
