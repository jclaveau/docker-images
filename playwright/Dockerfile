# syntax=docker/dockerfile:1
ARG BASE_IMAGE=jclaveau/ubuntu-dind:latest
FROM ${BASE_IMAGE}

# Renovate will update these
ARG NODE_VERSION=20.18.1
ARG PLAYWRIGHT_VERSION=1.48.2

# LABEL maintainer="your-email@example.com"
# LABEL org.opencontainers.image.source="https://github.com/yourusername/docker-images"
# LABEL org.opencontainers.image.description="Docker image with Playwright and DinD support"

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION%%.*}.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# https://github.com/pnpm/pnpm/issues/4495#issuecomment-1317831712
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"

RUN npm install -g pnpm

# Install Playwright globally
RUN pnpm install -g playwright@${PLAYWRIGHT_VERSION}
RUN playwright install-deps && playwright install --with-deps

# Set up working directory
WORKDIR /workspace

# Verify installations
RUN node --version \
    && npm --version \
    && pnpm --version \
    && playwright --version \
    && docker --version

CMD ["bash"]