#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

# Read port from Home Assistant options
PORT=$(jq -r '.port' $CONFIG_PATH)

echo "Starting Docker Socket Proxy on port ${PORT}..."

# Export the port for haproxy
export PORT="${PORT}"

# Enable common read-only operations by default
# These are safe operations that don't modify containers
export CONTAINERS=1
export IMAGES=1
export INFO=1
export NETWORKS=1
export VOLUMES=1
export VERSION=1
export EVENTS=1

# Disable dangerous operations by default
export AUTH=0
export SECRETS=0
export POST=0
export BUILD=0
export COMMIT=0
export CONFIGS=0
export DISTRIBUTION=0
export EXEC=0
export GRPC=0
export NODES=0
export PLUGINS=0
export SERVICES=0
export SESSION=0
export SWARM=0
export SYSTEM=0
export TASKS=0

echo "Docker Socket Proxy configuration:"
echo "  - Port: ${PORT}"
echo "  - Containers: ${CONTAINERS} (read-only)"
echo "  - Images: ${IMAGES} (read-only)"
echo "  - Networks: ${NETWORKS} (read-only)"
echo "  - Volumes: ${VOLUMES} (read-only)"

# Set file descriptor limit for haproxy
ulimit -n 10000

# Configure binding (IPv4/IPv6)
BIND_CONFIG="[::]:${PORT} v4v6"

# Generate haproxy config from template
sed "s/\${BIND_CONFIG}/${BIND_CONFIG}/g" /usr/local/etc/haproxy/haproxy.cfg.template > /tmp/haproxy.cfg

# Start haproxy with the socket proxy configuration
exec haproxy -W -db -f /tmp/haproxy.cfg
