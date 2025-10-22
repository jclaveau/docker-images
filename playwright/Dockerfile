# syntax=docker/dockerfile:1
ARG BASE_IMAGE=jclaveau/ubuntu-dind:latest
FROM ${BASE_IMAGE}

# Renovate will update these
ARG NODE_VERSION=22.12.0
ARG PLAYWRIGHT_VERSION=1.50.1

# LABEL maintainer="your-email@example.com"
# LABEL org.opencontainers.image.source="https://github.com/yourusername/docker-images"
# LABEL org.opencontainers.image.description="Docker image with Playwright and DinD support"

# ENV DEBIAN_FRONTEND=noninteractive

# https://github.com/pnpm/pnpm/issues/4495#issuecomment-1317831712
# ENV PNPM_HOME="/root/.local/share/pnpm"
# ENV PATH="${PATH}:${PNPM_HOME}"

# RUN npm install -g pnpm

USER runner

# ENV SHELL=bash
# RUN  curl -fsSL https://get.pnpm.io/install.sh | sh -

# PNPM_VERSION
ENV PNPM_HOME="/home/runner/.local/share/pnpm"
ENV PATH="${PATH}:${PNPM_HOME}"

# https://pnpm.io/installation#in-a-docker-container
RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -
# RUN source /home/runner/.bashrc

RUN cat /home/runner/.bashrc



USER root

# RUN pnpm env --global 22
# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION%%.*}.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*
USER runner



# Install Playwright globally https://playwright.dev/docs/docker#build-your-own-image
# RUN sudo pnpm install -g playwright@${PLAYWRIGHT_VERSION} --with-deps

ENV PLAYWRIGHT_BROWSERS_PATH='/home/runner/playwright-browsers'

# Install Playwright globally
RUN pnpm install -g playwright@${PLAYWRIGHT_VERSION}
RUN playwright install --with-deps --only-shell


# Verify installations
RUN node --version \
    && npm --version \
    && pnpm --version \
    && playwright --version \
    && docker --version
