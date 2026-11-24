FROM ghcr.io/home-operations/flate:0.7.0 AS upstream
FROM alpine:3.24.4

RUN apk add --no-cache ca-certificates
COPY --from=upstream /flate /usr/local/bin/flate

LABEL org.opencontainers.image.source="https://github.com/whaleyarn/flate"
CMD ["sh"]
