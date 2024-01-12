#!/bin/sh

set -e

# Download latest fabric installer
cd /opt/server
curl -Lo cursed-fabric-installer.jar `curl -s https://api.github.com/repos/BTW-Community/legacy-fabric-installer/releases/latest | jq -r '.assets[1]["browser_download_url"]'`
java -jar cursed-fabric-installer.jar server -mcversion 1.5.2 -loader "*-btw" -downloadMinecraft
rm cursed-fabric-installer.jar

# Download latest server zip and merge with vanilla jar
mkdir /tmp/server && cd /tmp/server
mv /opt/server/server.jar .

curl -Lo BTW-CE.zip `curl -s https://api.github.com/repos/BTW-Community/BTW-Public/releases/latest | jq -r '.assets[0]["browser_download_url"]'`
unzip server.jar
unzip -o BTW-CE.zip

jar cfe /opt/server/server.jar net.minecraft.server.MinecraftServer *
rm -rf /tmp/server
