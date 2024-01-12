FROM alpine:latest

RUN apk update
RUN apk --no-cache add openjdk8 curl jq

RUN addgroup -g 1000 server \
 && adduser -H -D -u 1000 -G server server

RUN mkdir /opt/server && mkdir /opt/server/world
#RUN chown server:server /opt/server && chmod 777 /opt/server/world

COPY init.sh start.sh /opt/server/
#COPY config/* /opt/server
#COPY world /opt/server
RUN chmod +x /opt/server/start.sh
RUN chmod +x /opt/server/init.sh

RUN /opt/server/init.sh
RUN chown -R server:server /opt/server/
RUN chown -R server:server /opt/server/world

USER server
WORKDIR /opt/server/
ENTRYPOINT ["/opt/server/start.sh"]
