FROM alpine:latest

RUN apk update && \
    apk add novnc
ENV VNC_HOST=localhost:5900
COPY ./files/ /app/
CMD [ "/app/entrypoint.sh" ]
EXPOSE 8080