FROM golang:1.16-alpine3.14

RUN addgroup -S ory; \
  adduser -S ory -G ory -D -H -s /bin/nologin

RUN apk --no-cache --update-cache --upgrade --latest add ca-certificates

ADD . /app
WORKDIR /app
ENV GO111MODULE on
RUN go get -u github.com/gobuffalo/packr/v2/packr2
RUN packr2
RUN go mod download && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

FROM alpine:3.16.0

COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0 /app/oathkeeper /usr/bin/oathkeeper
COPY --from=hairyhenderson/gomplate:stable /gomplate /usr/bin/gomplate
COPY oathkeeper.yml /.oathkeeper.tpl.yaml
COPY entrypoint.sh /etc/entrypoint.sh

RUN chmod +x /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]
CMD ["serve"]
