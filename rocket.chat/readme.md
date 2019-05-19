# Pre-setup

If you wish to create data volume and manage externally:

```
docker volume create rc_mongo_dump
docker volume create rc_mongo_db
docker volume create rc_mongo_configdb
docker volume create rc_uploads
docker volume create rc_mongo_repl_db
docker volume create rc_mongo_repl_configdb
```

# Startup

Run `docker-compose up -d`

This will take up to a couple of minute to initialize

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

Launch your browser, and navigate to `http://localhost:3000`
Follow the instruction

# Note

Since `Rocket.Chat v1.0.0`, it requires mongo [OPLOG/REPLICASET to run Rocket.Chat](https://github.com/RocketChat/Rocket.Chat/pull/14227)

Since `MongoDB v4.0`, MMAPv1 Storage Engine has been [deprecated](https://docs.mongodb.com/manual/core/mmapv1/) and will be removed in a future release. `--smallfiles` command is only available for the MMAPv1 storage engine