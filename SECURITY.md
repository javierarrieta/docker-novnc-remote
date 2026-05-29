# Security Policy

## Supported Versions

Only the latest release of this project receives security updates.

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it privately.

- **Do not** open a public issue — this will expose the vulnerability to everyone.
- Contact the maintainer at: https://github.com/javierarrieta

Include as much detail as possible:
- Steps to reproduce the vulnerability
- The impact of the vulnerability
- Any suggested mitigations

You will receive a response within 72 hours. If the vulnerability is confirmed, a fix will be prioritized and released as quickly as possible.

## Security Best Practices for This Image

- **Base image**: This image uses Alpine Linux, which receives regular security updates. Always pull the latest version of the image.
- **Running as non-root**: The container runs websockify as a non-root user. Do not override the USER directive.
- **VNC connection**: Ensure your VNC server uses TLS or is only accessible through trusted networks. The VNC protocol does not encrypt traffic by default.
- **Port exposure**: The default port (8080) is exposed without authentication. Consider using a reverse proxy with authentication if exposing this image to untrusted networks.
