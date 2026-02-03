# Home Assistant Add-on: Docker Socket Proxy

A secure Docker Socket Proxy add-on for Home Assistant using [Tecnativa/docker-socket-proxy](https://github.com/Tecnativa/docker-socket-proxy).

## About

This add-on provides a secure way to expose the Docker socket to other containers without giving them full access to Docker. It acts as a proxy that filters Docker API calls, only allowing safe read-only operations by default.

## Installation

1. Add this repository to your Home Assistant add-on store:

   [![Add repository to my Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FDJBenson%2Fha-docker-socket-proxy)

   Or manually add the repository URL:
   ```
   https://github.com/DJBenson/ha-docker-socket-proxy
   ```

2. Find the "Docker Socket Proxy" add-on and click Install
3. Configure the port (default: 2375)
4. Start the add-on

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| `port` | `2375` | The port on which the proxy will listen |

### Example configuration

```yaml
port: 2375
```

## Usage

Once running, you can connect to the Docker API through the proxy at:

```
tcp://homeassistant.local:2375
```

Or from within other containers on the same host:

```
tcp://172.30.32.1:2375
```

## Security

This proxy only allows **read-only** operations by default:

| Endpoint | Access |
|----------|--------|
| Containers | Read-only |
| Images | Read-only |
| Networks | Read-only |
| Volumes | Read-only |
| Info | Allowed |
| Version | Allowed |
| Events | Allowed |

All write operations and dangerous endpoints are disabled.

## Support

- [Issue Tracker](https://github.com/GITHUB_USERNAME/ha-docker-socket-proxy/issues)
- [Documentation](https://github.com/Tecnativa/docker-socket-proxy)
