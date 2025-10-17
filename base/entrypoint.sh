#!/bin/bash
set -e

# TODO add the user given with the option --user to docker group
# https://stackoverflow.com/questions/51342810/how-to-fix-dial-unix-var-run-docker-sock-connect-permission-denied-when-gro
echo "User $(id -u):$(id -g)"


# /!\ Very dangerous, do not use this outside dev env
# https://stackoverflow.com/a/54568062/2714285
sudo chmod 777 /var/run/docker.sock

usermod -aG docker "$(id -u)"


# Start Docker daemon in background
dockerd-entrypoint.sh &

# Wait for Docker to be ready
timeout 60 bash -c 'until docker info > /dev/null 2>&1; do sleep 1; done' || {
    echo "Docker daemon failed to start"
    exit 1
}

exec "$@"