FROM golang:1.22.24 as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o gha

FROM scratch
COPY --from=builder /app/gha /app
ENTRYPOINT [ "/app" ]