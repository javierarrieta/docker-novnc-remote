ARG BASE_IMAGE=alpine:latest
FROM ${BASE_IMAGE}

ARG NO_VNC_VERSION=1.4.0
ARG WEBSOCKIFY_VERSION=1.0.0

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
        novnc=${NO_VNC_VERSION} \
        websockify=${WEBSOCKIFY_VERSION} && \
    rm -rf /var/cache/apk/*

ENV VNC_HOST=localhost:5900 \
    VNC_PORT=5900 \
    NOVNC_PORT=8080 \
    USER=novnc \
    GROUP=novnc

RUN addgroup -S ${GROUP} && \
    adduser -S -D -H -g '' -h /home/${USER} -s /sbin/nologin -G ${GROUP} ${USER}

COPY --chown=${USER}:${GROUP} ./files/ /app/

USER ${USER}

EXPOSE ${NOVNC_PORT}

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:${NOVNC_PORT}/ || exit 1

CMD [ "/app/entrypoint.sh" ]