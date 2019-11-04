FROM golang AS build

RUN apt-get update && \
    apt-get install -y g++ libsystemd-dev git
RUN GOOS=linux GOARCH=amd64 go get -ldflags="-w -s" github.com/kumina/postfix_exporter && ls -l $PWD/bin/*


FROM golang
COPY --from=build /go/bin/postfix_exporter /app/postfix_exporter
RUN ls -l /app/*

ENTRYPOINT ["/app/postfix_exporter"]
