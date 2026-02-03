ARG BUILD_FROM=tecnativa/docker-socket-proxy:latest
FROM ${BUILD_FROM}

# Install bashio for Home Assistant configuration parsing
RUN apk add --no-cache bash jq

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Set entrypoint
ENTRYPOINT ["/run.sh"]
