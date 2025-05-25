ARG BUILD_FROM
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set pocket-id version
ARG POCKET_ID_VERSION="v1.0.0"

# Install Pocket ID
ARG BUILD_ARCH=amd64
RUN \
    set -eux \
    \
    && if [[ "$BUILD_ARCH" = "aarch64" ]]; then ARCH="arm64"; fi \
    && if [[ "$BUILD_ARCH" = "amd64" ]]; then ARCH="amd64"; fi \
    \
    && curl -J -L -o /usr/local/bin/pocket-id "https://github.com/pocket-id/pocket-id/releases/download/${POCKET_ID_VERSION}/pocket-id-linux-${ARCH}" \
    \
    && chmod +x /usr/local/bin/pocket-id

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Add-on Labels
LABEL \
  io.hass.name="${BUILD_NAME}" \
  io.hass.description="${BUILD_DESCRIPTION}" \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="addon" \
  io.hass.arch="aarch64|amd64" \
  maintainer="Einschmidt <github@schmidtnb.de>" \
  description="Pocket ID - Simple OIDC provider for passkey authentication" \
  org.opencontainers.image.source="https://github.com/pocket-id/pocket-id" \
  org.opencontainers.image.licenses="MIT"
