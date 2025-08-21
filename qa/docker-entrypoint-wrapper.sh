#!/bin/bash

# First, run the original WordPress entrypoint script
# This is typically at /usr/local/bin/docker-entrypoint.sh
/usr/local/bin/docker-entrypoint.sh "$@" &

# Store the PID of the WordPress process
WP_PID=$!

# Run our custom setup script in the background
# It will wait for WordPress to initialize before running
/usr/local/bin/wordpress-setup.sh &

# Wait for the WordPress process to finish
wait $WP_PID