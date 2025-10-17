# syntax=docker/dockerfile:1
ARG BASE_IMAGE=yourusername/ubuntu-dind:latest
FROM ${BASE_IMAGE}

# Renovate will update these
ARG NODE_VERSION=20.18.1
ARG PLAYWRIGHT_VERSION=1.48.2

LABEL maintainer="your-email@example.com"
LABEL org.opencontainers.image.source="https://github.com/yourusername/docker-images"
LABEL org.opencontainers.image.description="Docker image with Playwright and DinD support"

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION%%.*}.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright system dependencies
RUN apt-get update && apt-get install -y \
    # Chromium dependencies
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    # Firefox dependencies
    libdbus-glib-1-2 \
    libxt6 \
    # WebKit dependencies
    libwoff1 \
    libopus0 \
    libwebpdemux2 \
    libharfbuzz-icu0 \
    libgstreamer-gl1.0-0 \
    libgstreamer-plugins-bad1.0-0 \
    libenchant-2-2 \
    libsecret-1-0 \
    libhyphen0 \
    libmanette-0.2-0 \
    libevdev2 \
    libgles2 \
    # Additional tools
    fonts-liberation \
    fonts-noto-color-emoji \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright globally
RUN npm install -g playwright@${PLAYWRIGHT_VERSION} \
    && playwright install --with-deps

# Set up working directory
WORKDIR /workspace

# Verify installations
RUN node --version \
    && npm --version \
    && playwright --version \
    && docker --version

CMD ["bash"]