# Pre-setup

If you wish to create data volume and manage externally:

```
docker volume create bitnami_kakfa_lib
```

# Startup

Run `docker compose up -d`

# Remove

Run `docker compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

Launch your browser, and navigate to `http://localhost:9090`
