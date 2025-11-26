FROM golang:1.20.3-alpine3.17 as builder

WORKDIR /usr/src/pdsync

COPY . .
COPY config.yaml /pdsync/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -mod vendor -o /pdsync

FROM gcr.io/distroless/static-debian11 as runner
COPY --from=builder /pdsync /
ENTRYPOINT ["/pdsync"]
