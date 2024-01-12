#!/bin/sh

SERVER_JAR="/opt/server/fabric-server-launch.jar"
java -server \
    -Xmx1024M \
    -XX:+UseConcMarkSweepGC \
    -XX:+UseParNewGC \
    -XX:+CMSIncrementalPacing \
    -XX:ParallelGCThreads=2 \
    -XX:+AggressiveOpts \
    -jar "$SERVER_JAR" nogui
