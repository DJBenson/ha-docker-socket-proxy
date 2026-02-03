# Home Assistant Add-on: Docker Socket Proxy

## How it works

This add-on runs a HAProxy-based proxy that sits between your applications and the Docker socket. Instead of giving containers direct access to `/var/run/docker.sock`, they connect to this proxy which filters requests and only allows safe operations.

## Configuration

### Option: `port`

The network port on which the Docker Socket Proxy will listen. Default is `2375` (the standard Docker API port).

### Read-only API Options (enabled by default)

| Option | Default | Description |
|--------|---------|-------------|
| `containers` | `true` | Allow listing and inspecting containers |
| `images` | `true` | Allow listing and inspecting images |
| `info` | `true` | Allow Docker system information |
| `networks` | `true` | Allow listing and inspecting networks |
| `volumes` | `true` | Allow listing and inspecting volumes |
| `version` | `true` | Allow Docker version information |
| `events` | `true` | Allow Docker event stream |

### Write/Dangerous API Options (disabled by default)

| Option | Default | Description |
|--------|---------|-------------|
| `post` | `false` | Allow POST requests (required for write operations) |
| `auth` | `false` | Allow auth operations |
| `build` | `false` | Allow building images |
| `commit` | `false` | Allow committing containers to images |
| `configs` | `false` | Allow config management |
| `distribution` | `false` | Allow distribution operations |
| `exec` | `false` | Allow exec into containers |
| `grpc` | `false` | Allow gRPC operations |
| `nodes` | `false` | Allow node management |
| `plugins` | `false` | Allow plugin management |
| `secrets` | `false` | Allow secrets management |
| `services` | `false` | Allow service management |
| `session` | `false` | Allow session operations |
| `swarm` | `false` | Allow swarm operations |
| `system` | `false` | Allow system operations |
| `tasks` | `false` | Allow task management |

**Warning**: Enabling write operations reduces security. Only enable what you need.

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
