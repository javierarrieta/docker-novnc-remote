#!/bin/sh

# Check if websockify is available
if ! command -v websockify >/dev/null 2>&1; then
    echo "ERROR: websockify is not installed" >&2
    exit 1
fi

# Check if novnc is available
if ! command -v novnc >/dev/null 2>&1; then
    echo "ERROR: novnc is not installed" >&2
    exit 1
fi

# Validate VNC_HOST format
if ! echo "$VNC_HOST" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$'; then
    echo "WARNING: VNC_HOST format may be invalid. Expected <IP>:<PORT>, got: $VNC_HOST" >&2
fi

# Start websockify
websockify --web /usr/share/novnc "${NOVNC_PORT}" "${VNC_HOST}"
