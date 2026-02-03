#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

# Helper function to convert boolean to 0/1
bool_to_int() {
  if [ "$1" = "true" ]; then
    echo "1"
  else
    echo "0"
  fi
}

# Read options from Home Assistant config
PORT=$(jq -r '.port' $CONFIG_PATH)

echo "Starting Docker Socket Proxy on port ${PORT}..."

# Export the port for haproxy
export PORT="${PORT}"

# Read-only operations
export CONTAINERS=$(bool_to_int "$(jq -r '.containers' $CONFIG_PATH)")
export IMAGES=$(bool_to_int "$(jq -r '.images' $CONFIG_PATH)")
export INFO=$(bool_to_int "$(jq -r '.info' $CONFIG_PATH)")
export NETWORKS=$(bool_to_int "$(jq -r '.networks' $CONFIG_PATH)")
export VOLUMES=$(bool_to_int "$(jq -r '.volumes' $CONFIG_PATH)")
export VERSION=$(bool_to_int "$(jq -r '.version' $CONFIG_PATH)")
export EVENTS=$(bool_to_int "$(jq -r '.events' $CONFIG_PATH)")

# Write/dangerous operations
export POST=$(bool_to_int "$(jq -r '.post' $CONFIG_PATH)")
export AUTH=$(bool_to_int "$(jq -r '.auth' $CONFIG_PATH)")
export BUILD=$(bool_to_int "$(jq -r '.build' $CONFIG_PATH)")
export COMMIT=$(bool_to_int "$(jq -r '.commit' $CONFIG_PATH)")
export CONFIGS=$(bool_to_int "$(jq -r '.configs' $CONFIG_PATH)")
export DISTRIBUTION=$(bool_to_int "$(jq -r '.distribution' $CONFIG_PATH)")
export EXEC=$(bool_to_int "$(jq -r '.exec' $CONFIG_PATH)")
export GRPC=$(bool_to_int "$(jq -r '.grpc' $CONFIG_PATH)")
export NODES=$(bool_to_int "$(jq -r '.nodes' $CONFIG_PATH)")
export PLUGINS=$(bool_to_int "$(jq -r '.plugins' $CONFIG_PATH)")
export SECRETS=$(bool_to_int "$(jq -r '.secrets' $CONFIG_PATH)")
export SERVICES=$(bool_to_int "$(jq -r '.services' $CONFIG_PATH)")
export SESSION=$(bool_to_int "$(jq -r '.session' $CONFIG_PATH)")
export SWARM=$(bool_to_int "$(jq -r '.swarm' $CONFIG_PATH)")
export SYSTEM=$(bool_to_int "$(jq -r '.system' $CONFIG_PATH)")
export TASKS=$(bool_to_int "$(jq -r '.tasks' $CONFIG_PATH)")

echo "Docker Socket Proxy configuration:"
echo "  Port: ${PORT}"
echo "  Read-only APIs:"
echo "    containers=${CONTAINERS} images=${IMAGES} info=${INFO} networks=${NETWORKS}"
echo "    volumes=${VOLUMES} version=${VERSION} events=${EVENTS}"
echo "  Write APIs:"
echo "    post=${POST} auth=${AUTH} build=${BUILD} commit=${COMMIT}"
echo "    configs=${CONFIGS} exec=${EXEC} system=${SYSTEM}"

# Set file descriptor limit for haproxy
ulimit -n 10000

# Configure binding (IPv4/IPv6)
BIND_CONFIG="[::]:${PORT} v4v6"

# Generate haproxy config from template
sed "s/\${BIND_CONFIG}/${BIND_CONFIG}/g" /usr/local/etc/haproxy/haproxy.cfg.template > /tmp/haproxy.cfg

# Start haproxy with the socket proxy configuration
exec haproxy -W -db -f /tmp/haproxy.cfg
