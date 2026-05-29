# docker-novnc-remote

Docker image to expose a remote VNC server via noVNC.

## Security

This image runs as a non-root user. See [SECURITY.md](SECURITY.md) for security best practices and vulnerability reporting.

## Usage

```bash
docker run -d \
  --name novnc-remote \
  -p 8080:8080 \
  -e VNC_HOST=192.168.1.100:5900 \
  javierarrieta/docker-novnc-remote:latest
```

## Configuration

| Variable       | Description                    | Default       |
|---------------|--------------------------------|---------------|
| `VNC_HOST`    | VNC server host and port       | `localhost:5900` |
| `NOVNC_PORT`  | Port to expose noVNC on        | `8080`        |

## Access

Open a browser and navigate to `http://<host>:8080` to connect to your VNC server.

## Notes

- The VNC protocol does not encrypt traffic by default. Use a reverse proxy with TLS if exposing this to untrusted networks.
- Ensure your VNC server is configured to only accept connections from trusted sources.
