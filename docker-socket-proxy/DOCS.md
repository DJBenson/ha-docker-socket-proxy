# Home Assistant Add-on: Docker Socket Proxy

## How it works

This add-on runs a HAProxy-based proxy that sits between your applications and the Docker socket. Instead of giving containers direct access to `/var/run/docker.sock`, they connect to this proxy which filters requests and only allows safe operations.

## Configuration

### Option: `port`

The network port on which the Docker Socket Proxy will listen. Default is `2375` (the standard Docker API port).

## Allowed Operations

By default, this proxy allows read-only access to:

- **Containers**: List and inspect containers
- **Images**: List and inspect images
- **Networks**: List and inspect networks
- **Volumes**: List and inspect volumes
- **Info**: Docker system information
- **Version**: Docker version information
- **Events**: Docker event stream

## Blocked Operations

The following dangerous operations are blocked:

- Creating, starting, stopping, or removing containers
- Building or pushing images
- Creating or removing networks/volumes
- Executing commands in containers
- Swarm operations
- Plugin management
- System modifications

## Use Cases

### Monitoring Tools

Tools like Portainer (read-only mode), Prometheus Docker exporters, or custom dashboards can use this proxy to safely monitor your Docker environment.

### Integration with Other Add-ons

Other Home Assistant add-ons that need to list Docker containers can connect to this proxy instead of requiring direct socket access.

## Connecting to the Proxy

From the host network:
```
DOCKER_HOST=tcp://localhost:2375
```

From Home Assistant containers:
```
DOCKER_HOST=tcp://172.30.32.1:2375
```

## Troubleshooting

### Proxy not starting

Check the add-on logs for error messages. Ensure the configured port is not already in use.

### Connection refused

Make sure the add-on is running and the port is correct. The proxy binds to all interfaces (0.0.0.0).

### Permission denied for certain operations

This is expected behavior. The proxy blocks write operations by design for security reasons.
