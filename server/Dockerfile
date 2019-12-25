FROM golang:alpine
RUN apk --no-cache add gcc g++ make git
WORKDIR /go/src/app
COPY . .
RUN go get ./...
RUN GOOS=linux go build -ldflags="-s -w" -o ./bin/server ./server.go

FROM alpine:3.9
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=0 /go/src/app/bin /go/bin
EXPOSE 80
ENTRYPOINT /go/bin/server --port 80
