FROM alpine:latest

# Apply security updates and install packages without cache
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
        novnc \
        websockify \
        wget && \
    rm -rf /var/cache/apk/*

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
