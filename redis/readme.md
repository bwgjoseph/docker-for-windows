# Pre-setup

If you wish to create data volume and manage externally:

`docker volume create redis_data`

# Startup

Run `docker-compose up -d`

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

## Using redis-cli

To connect to redis to use redis-cli:

Ensure in the same network as redis
Pass in host command to specify redis (which is defined in docker-compose) service name

`docker run --name rd-cli --network=redis_redisnet --rm -it redis:5.0.5-alpine redis-cli -h redis`

After connected, type `ping` and you should receive `pong` reply. The container will be removed automatically once the session is closed