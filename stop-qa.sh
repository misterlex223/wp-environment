#!/bin/bash

# Stop the QA environment
cd "$(dirname "$0")/qa"
echo "Stopping WordPress QA environment..."
docker-compose down

echo "QA environment stopped."
