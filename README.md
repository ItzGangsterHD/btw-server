A **Docker** project to build the **Better Than Wolves** Minecraft server

[Official Better Than Wolves Wiki](https://wiki.btwce.com/index.php?title=Main_Page)

This project is an updated version of [this](https://github.com/GencoreOperative/btw-server) project.


## Requirements

This project assumes the user has **Docker** installed and has some basic knowledge of **Docker** commands.

## Running

To run this project you can either use `docker-compose` or `docker run` like so

```sh
docker-compose up --build -d
```
(use `--build` only the first time)

or

```sh
docker run \
  	--name btw-server \
  	-p 25565:25565 \
  	-v world:/opt/server/world \
  	-v data:/opt/server/data \
  	--restart unless-stopped \
  	-e PUID=1000 \
  	-e PGID=1000 \
  	-it \
	-d \
  	gqngster/btw-server
```

In both commands the **Docker** container will be started in the background.

## Managing

To attach to the server and issue server commands:

```sh
docker attach btw-server
```

And to exit this attached mode we need to press:

```sh
CTRL+P + CTRL+Q
```

To stop the server:

```sh
docker stop btw-server
```

To start it back up after being stopped:

```sh
docker start btw-server
```

To restart it:

```sh
docker restart btw-server
```

To view the logs:

```
docker logs -f btw-server
```

To list volumes (will be useful for backing up):
```sh
docker volume ls
```

## Backup

The world data is stored within a **Docker** volume called `world` or `btw-server_world` (if running with `docker-compose`) and the configuration/mods are stored in `data` or `btw-server_data` respectively.

If we want to back up a volume, we can do:

```sh
docker run -it --rm -v <volume_name>:/volume -v "$(pwd)":/backup alpine tar cjf /backup/backup.tar.bz2 -C /volume ./
```

This will create a `backup.tar.bz2` file in your local folder.

You can change the volume name to match what you want to backup.

### Restoring a backup

To restore a backup we need to first ensure the volume is removed:

```sh
docker volume rm -f <volume_name>
```

And then we can copy the backup data into the volume using:
```sh
docker run -it --rm -v <volume_name>:/volume -v "$(pwd):/backup alpine tar xjvf /backup/backup.tar.bz2 -C /volume
```
