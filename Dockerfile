FROM golang:1.11.0-alpine as build
ENV GO111MODULE=on

RUN apk add --update --no-cache build-base git

WORKDIR /src

COPY go.mod .
RUN go mod download

COPY *.go .
RUN go build -o /bin/testapi .

FROM alpine:latest

RUN apk add --update --no-cache ca-certificates

COPY --from=build /bin/testapi /bin/testapi

ENTRYPOINT ["/bin/testapi"]