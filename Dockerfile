ARG BASE_IMAGE=alpine:latest
FROM ${BASE_IMAGE}

ARG NODE_VERSION=22

# Install Node.js and required tools for build
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
        nodejs-${NODE_VERSION} \
        npm \
        wget && \
    rm -rf /var/cache/apk/*

# Install novnc and websockify via npm (they are Node.js packages, not Alpine packages)
RUN npm install -g novnc@1.2.0 websockify@0.7.1

ENV VNC_HOST=localhost:5900 \
    NOVNC_PORT=8080

# Create non-root user
RUN addgroup -S novnc && \
    adduser -S -D -H -g '' -h /home/novnc -s /sbin/nologin -G novnc novnc

# Install application files
COPY --chown=novnc:novnc ./files/ /app/

USER novnc

EXPOSE ${NOVNC_PORT}

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:${NOVNC_PORT}/ || exit 1

CMD [ "/app/entrypoint.sh" ]
