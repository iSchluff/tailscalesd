FROM golang:1.20 AS builder
LABEL maintainer="Simon Elsbrock <simon@iodev.org>"
LABEL org.opencontainers.image.description="Prometheus Service Discovery for Tailscale"

COPY . /work/
WORKDIR /work
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ./cmd/tailscalesd

FROM debian:11
COPY --from=builder /work/tailscalesd /tailscalesd

ENTRYPOINT ["/tailscalesd"]
CMD []
