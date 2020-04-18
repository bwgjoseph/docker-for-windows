# Pre-setup

If you wish to create data volume and manage externally:

`docker volume create hivemq_data`
`docker volume create hivemq_log`

# Startup

Run `docker-compose up -d`

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

To connect through:

`mqtt: mqtt:localhost:1833`
`websocket: ws://localhost:8000/mqtt`