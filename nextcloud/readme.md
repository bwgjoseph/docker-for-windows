# Pre-setup

If you wish to create data volume and manage externally:

```
docker volume create nc_server_appdata
docker volume create nc_maria_data
docker volume create nc_onlyoffice_data
docker volume create nc_onlyoffice_log
docker volume create nc_onlyoffice_postgresql
docker volume create nc_onlyoffice_fonts
docker volume create nc_onlyoffice_lib
```

# Startup

Run `docker-compose up -d`

This will take up to a couple of minute to initialize

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

Launch your browser, and navigate to `http://localhost:7000`
Create an admin account
Run `bash set_configuration.sh`
Login nextcloud > settings > ONLYOFFICE > Document Editing Service and set `address=/ds-vpath/`

# Export

## Container

Ensure container are not running before exporting

To save the images to tar file. Run `export_container.bat`

## Volume

Note: Windows path separator must be `//`
{windows.path} example: `Z://docker-for-windows//nextcloud//backup`

#### Backup

To backup data from docker volume into tar file. Run `export.bat`

### Restore

To restore data from tar file into docker volume. Run `import.bat`

# Note

Account: `admin / Password1Nextcloud`
View content of volume: `docker run -rm -it -v nextcloud_nc_server_appdata:/var/www/html busybox`
View content of container: `docker exec -rm -it onlyoffice_document_server bash`

# Reference

[onlyoffice-docker-installation](https://helpcenter.onlyoffice.com/server/docker/document/docker-installation.asp)
[docker-onlyoffice-nextcloud](https://github.com/ONLYOFFICE/docker-onlyoffice-nextcloud)
[how-to-install-nextcloud-talk-using-docker-on-alibaba-cloud](https://medium.com/@Alibaba_Cloud/how-to-install-nextcloud-talk-using-docker-on-alibaba-cloud-ffc8fb326405)
[onlyoffice-nextcloud](https://github.com/ONLYOFFICE/onlyoffice-nextcloud)
[nextcloud/docker](https://github.com/nextcloud/docker)
[docker-backup-volumes](https://blog.ssdnodes.com/blog/docker-backup-volumes/)