# Home Assistant Add-on: Docker Socket Proxy

A secure Docker Socket Proxy add-on for Home Assistant using [Tecnativa/docker-socket-proxy](https://github.com/Tecnativa/docker-socket-proxy).

## About

This add-on provides a secure way to expose the Docker socket to other containers without giving them full access to Docker. It acts as a proxy that filters Docker API calls, allowing you to control exactly which operations are permitted.

## Installation

1. Add this repository to your Home Assistant add-on store:

   [![Add repository to my Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FDJBenson%2Fha-docker-socket-proxy)

   Or manually add the repository URL:
   ```
   https://github.com/DJBenson/ha-docker-socket-proxy
   ```

2. Find the "HA Docker Socket Proxy" add-on and click Install
3. **Disable Protection Mode** (required for Docker socket access)
4. Configure options as needed
5. Start the add-on

## Configuration

All Docker API endpoints can be individually enabled or disabled through the add-on configuration UI.

### Safe Options (enabled by default)

| Option | Description |
|--------|-------------|
| `containers` | List and inspect containers |
| `images` | List and inspect images |
| `networks` | List and inspect networks |
| `volumes` | List and inspect volumes |
| `info` | Docker system information |
| `version` | Docker version information |
| `events` | Docker event stream |

### Dangerous Options (disabled by default)

| Option | Description |
|--------|-------------|
| `post` | Allow POST/PUT/DELETE requests (required for any write operation) |
| `exec` | Execute commands in containers |
| `build` | Build Docker images |
| `commit` | Commit container changes to images |
| `system` | System operations (prune, df, etc.) |
| ... | And many more - see add-on configuration for full list |

## Usage

Once running, connect to the Docker API through the proxy:

From the host network:
```
DOCKER_HOST=tcp://localhost:2375
```

From Home Assistant containers:
```
DOCKER_HOST=tcp://172.30.32.1:2375
```

## Translations

The add-on UI is available in:
- English
- German
- French
- Spanish
- Italian
- Dutch
- Portuguese

## Support

- [Issue Tracker](https://github.com/DJBenson/ha-docker-socket-proxy/issues)
- [Tecnativa docker-socket-proxy Documentation](https://github.com/Tecnativa/docker-socket-proxy)
