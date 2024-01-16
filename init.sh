#!/bin/sh

set -e

# Downloading latest BTW fabric installer
cd /opt/server
curl -sLo cursed-fabric-installer.jar `curl -s https://api.github.com/repos/BTW-Community/legacy-fabric-installer/releases/latest | jq -r '.assets[1]["browser_download_url"]'`
java -jar cursed-fabric-installer.jar server -mcversion 1.5.2 -loader "*-btw" -downloadMinecraft
rm cursed-fabric-installer.jar

# Downloading latest BTW server zip and merging with vanilla jar
mkdir /tmp/server
cd /tmp/server
mv /opt/server/server.jar .

curl -sLo BTW-CE.zip `curl -s https://api.github.com/repos/BTW-Community/BTW-Public/releases/latest | jq -r '.assets[0]["browser_download_url"]'`
unzip server.jar
unzip -o BTW-CE.zip

jar cfe /opt/server/server.jar net.minecraft.server.MinecraftServer *
rm -rf /tmp/server

# Separating data and jar files
echo "serverJar=../server.jar" > /opt/server/data/fabric-server-launcher.properties

# Generating `level-name` manually so the world folder does not mix with the data
echo \
"generator-settings=
allow-nether=true
level-name=../world
enable-query=false
allow-flight=false
server-port=25565
level-type=DEFAULT
enable-rcon=false
force-gamemode=false
level-seed=
server-ip=
max-build-height=256
spawn-npcs=true
white-list=false
spawn-animals=true
texture-pack=
snooper-enabled=true
hardcore=false
online-mode=true
pvp=true
difficulty=standard
gamemode=0
max-players=20
view-distance=10
generate-structures=true
spawn-protection=16" > /opt/server/data/server.properties

# Removing unnecessary packages
apk del curl jq
