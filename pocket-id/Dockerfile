ARG BUILD_FROM
FROM ghcr.io/pocket-id/pocket-id:v0.46.0

# Install jq for JSON parsing
# hadolint ignore=DL3018
RUN apk add --no-cache jq

# Copy custom startup script
COPY run.sh /app/scripts/docker/run.sh

# Ensure correct permissions for Home Assistant add-ons
RUN chmod +x /app/scripts/docker/*.sh

# Set `run.sh` as ENTRYPOINT
ENTRYPOINT ["sh", "/app/scripts/docker/run.sh"]

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
