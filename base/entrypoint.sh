#!/bin/bash
set -e

# Start Docker daemon in background
dockerd-entrypoint.sh &

# Wait for Docker to be ready
timeout 60 bash -c 'until docker info > /dev/null 2>&1; do sleep 1; done' || {
    echo "Docker daemon failed to start"
    exit 1
}

exec "$@"