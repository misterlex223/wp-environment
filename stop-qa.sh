#!/bin/bash

# Stop the QA environment
cd "$(dirname "$0")/qa"

# Check if release-volumes parameter is provided
VOLUME_FLAG="--volumes"
if [ "$1" == "--keep-volumes" ] || [ "$1" == "-k" ]; then
    VOLUME_FLAG=""
    echo "Stopping WordPress QA environment (keeping volumes)..."
else
    echo "Stopping WordPress QA environment (removing volumes)..."
    echo "(Use --keep-volumes or -k parameter to keep volumes)"
fi

docker compose down $VOLUME_FLAG

echo "QA environment stopped."
