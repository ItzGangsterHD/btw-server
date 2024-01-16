#!/bin/sh

java -server \
    -Xmx1024M \
    -XX:+UseConcMarkSweepGC \
    -XX:+UseParNewGC \
    -XX:+CMSIncrementalPacing \
    -XX:ParallelGCThreads=2 \
    -XX:+AggressiveOpts \
    -jar /opt/server/fabric-server-launch.jar nogui
