#!/bin/sh
set -e

CONFIG_PATH="/app/data/options.json"

# Ensure the config file exists before proceeding
if [ ! -f "$CONFIG_PATH" ]; then
    echo "Error: Configuration file not found at $CONFIG_PATH"
    exit 1
fi

# Extract values from JSON and handle potential null values
APP_URL=$(jq -r '.APP_URL // "http://localhost"' "$CONFIG_PATH")
TRUST_PROXY=$(jq -r '.TRUST_PROXY // "false"' "$CONFIG_PATH")
MAXMIND_LICENSE_KEY=$(jq -r '.MAXMIND_LICENSE_KEY // ""' "$CONFIG_PATH")
UPDATE_CHECK_DISABLED=true

export APP_URL
export TRUST_PROXY
export MAXMIND_LICENSE_KEY
export UPDATE_CHECK_DISABLED

# Debug output to verify values
echo "Exported environment variables:"
env | grep -E 'APP_URL|TRUST_PROXY|UPDATE_CHECK_DISABLED'

# Run create-user.sh first
echo "Running create-user.sh..."
sh /app/scripts/docker/create-user.sh

# Run entrypoint.sh
echo "Running entrypoint.sh..."
exec sh /app/scripts/docker/entrypoint.sh
