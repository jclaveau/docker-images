# syntax=docker/dockerfile:1
FROM ubuntu:24.04

# Renovate will update this
ARG DOCKER_VERSION=27.4.0
ARG DOCKER_COMPOSE_VERSION=2.30.3

# LABEL maintainer="your-email@example.com"
# LABEL org.opencontainers.image.source="https://github.com/yourusername/docker-images"
# LABEL org.opencontainers.image.description="Ubuntu base image with Docker-in-Docker support"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    iptables \
    supervisor \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Configure Docker daemon
RUN mkdir -p /etc/docker && \
    echo '{"storage-driver": "overlay2", "log-driver": "json-file", "log-opts": {"max-size": "10m", "max-file": "3"}}' \
    > /etc/docker/daemon.json

# Setup entrypoint for DinD
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh


VOLUME /var/lib/docker

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]