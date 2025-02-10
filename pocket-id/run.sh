#!/bin/sh
set -e

CONFIG_PATH="/app/backend/data/options.json"

# Ensure the config file exists before proceeding
if [ ! -f "$CONFIG_PATH" ]; then
    echo "Error: Configuration file not found at $CONFIG_PATH"
    exit 1
fi

# Extract values from JSON and handle potential null values
PUBLIC_APP_URL=$(jq -r '.PUBLIC_APP_URL // "http://localhost"' "$CONFIG_PATH")
TRUST_PROXY=$(jq -r '.TRUST_PROXY // "false"' "$CONFIG_PATH")
MAXMIND_LICENSE_KEY=$(jq -r '.MAXMIND_LICENSE_KEY // ""' "$CONFIG_PATH")

export PUBLIC_APP_URL
export TRUST_PROXY
export MAXMIND_LICENSE_KEY

# Debug output to verify values
echo "Exported environment variables:"
env | grep -E 'PUBLIC_APP_URL|TRUST_PROXY'

# Run create-user.sh first
echo "Running create-user.sh..."
sh /app/scripts/docker/create-user.sh

# Run entrypoint.sh
echo "Running entrypoint.sh..."
exec sh /app/scripts/docker/entrypoint.sh
