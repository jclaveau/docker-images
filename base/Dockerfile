# syntax=docker/dockerfile:1
FROM ubuntu:24.04

# Renovate will update this
ARG DOCKER_VERSION=28.5.1
ARG DOCKER_COMPOSE_VERSION=2.39.4
ARG DOCKER_GROUP_ID=${DOCKER_GROUP_ID}


# LABEL maintainer="your-email@example.com"
# LABEL org.opencontainers.image.source="https://github.com/yourusername/docker-images"
# LABEL org.opencontainers.image.description="Ubuntu base image with Docker-in-Docker support"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies & basic tools
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    iptables \
    supervisor \
    git \
    net-tools \
    iputils-ping \
    nano \
    sudo \
    && rm -rf /var/lib/apt/lists/*


# Set same users as in ubuntu-latest of Github
RUN (userdel -r $(getent passwd 1000 | cut -d: -f1) 2>/dev/null || true) && \
    (userdel -r $(getent passwd 1001 | cut -d: -f1) 2>/dev/null || true) && \
    (userdel -r packer 2>/dev/null || true) && \
    (userdel -r runner 2>/dev/null || true)

RUN useradd -m -s /bin/bash -u 1000 -c "Ubuntu" packer && \
    echo "packer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/packer && \
    chmod 0440 /etc/sudoers.d/packer

RUN useradd -m -s /bin/bash -u 1001 -c ",,," runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/runner && \
    chmod 0440 /etc/sudoers.d/runner

# WORKDIR /home/runner # This will be overridden by Github
# VOLUME /home/runner:/home/runner # This doesn't seem to work


# Use the same group id as in Github's ubuntu-latest https://github.com/jclaveau/docker-images/actions/runs/18673089597/job/53237768539
# https://medium.com/@flnzba/37-running-a-docker-container-in-a-docker-container-dind-dc60ff298e82#a5b4
RUN groupadd -g ${DOCKER_GROUP_ID} docker

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


VOLUME /var/lib/docker

RUN cat /etc/group


RUN usermod -aG docker packer && \
    usermod -aG runner,adm,users,systemd-journal,docker runner

# Setup entrypoint for DinD
# COPY entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/entrypoint.sh
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  # This will be overridden by Github

# CMD ["cd", "$PWD"]