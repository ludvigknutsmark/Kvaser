FROM golang:alpine
RUN apk add --no-cache git mercurial \
    && go get github.com/gorilla/sessions \
    && apk del git mercurial
RUN apk add bash
ADD ./src /go/src/app
COPY ./src/certs/server.key /go/src/app
COPY ./src/certs/server.crt /go/src/app
WORKDIR /go/src/app
ENV GOBIN /go/bin
CMD ["go", "run", "server.go"]
