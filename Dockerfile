FROM alpine:latest

RUN apk update \
 && apk --no-cache add openjdk8 curl jq

RUN addgroup -g 1000 server \
 && adduser -H -D -u 1000 -G server server

RUN mkdir /opt/server \
 && mkdir /opt/server/world \
 && mkdir /opt/server/data

COPY init.sh start.sh /opt/server/
RUN chmod +x /opt/server/start.sh \
 && chmod +x /opt/server/init.sh

RUN /opt/server/init.sh \
 && rm /opt/server/init.sh

RUN chown -R server:server /opt/server/

WORKDIR /opt/server/data
USER server
ENTRYPOINT ["/opt/server/start.sh"]
