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

```
docker export nginx-server > container/nginx-server.tar
docker export nextcloud-server > container/nextcloud-server.tar
docker export nextcloud-mariadb > container/nextcloud-mariadb.tar
docker export onlyoffice-document-server > container/onlyoffice-document-server.tar
```

## Volume

Note: Windows path separator must be `//`
{windows.path} example: `Z://docker-for-windows//nextcloud//backup`

#### Backup

```
docker run --rm --volumes-from nextcloud-server -v {windows.path}:/backup ubuntu bash -c "cd /var/www/html && tar cvf /backup/nextcloud-server-data.tar ."
docker run --rm --volumes-from nextcloud-mariadb -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/mysql && tar cvf /backup/nextcloud-mariadb-data.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v {windows.path}:/backup ubuntu bash -c "cd /var/www/onlyoffice/Data && tar cvf /backup/onlyoffice-document-server-data.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v {windows.path}:/backup ubuntu bash -c "cd /var/log/onlyoffice && tar cvf /backup/onlyoffice-document-server-log.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/postgresql && tar cvf /backup/onlyoffice-document-server-postgresql.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v {windows.path}:/backup ubuntu bash -c "cd /usr/share/fonts/truetype/custom && tar cvf /backup/onlyoffice-document-server-fonts.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/onlyoffice && tar cvf /backup/onlyoffice-document-server-lib.tar ."
```

### Restore

```
docker volume create nextcloud_nc_server_appdata
docker volume create nextcloud_nc_maria_data
docker volume create nextcloud_nc_onlyoffice_data
docker volume create nextcloud_nc_onlyoffice_log
docker volume create nextcloud_nc_onlyoffice_postgresql
docker volume create nextcloud_nc_onlyoffice_fonts
docker volume create nextcloud_nc_onlyoffice_lib
```

```
docker run --rm -v nextcloud_nc_server_appdata:/var/www/html -v {windows.path}:/backup ubuntu bash -c "cd /var/www/html && tar xvf /backup/nextcloud-server-data.tar"
docker run --rm -v nextcloud_nc_maria_data:/var/lib/mysql -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/mysql && tar xvf /backup/nextcloud-mariadb-data.tar"
docker run --rm -v nextcloud_nc_onlyoffice_data:/var/www/onlyoffice/Data -v {windows.path}:/backup ubuntu bash -c "cd /var/www/onlyoffice/Data && tar xvf /backup/onlyoffice-document-server-data.tar"
docker run --rm -v nextcloud_nc_onlyoffice_log:/var/log/onlyoffice -v {windows.path}:/backup ubuntu bash -c "cd /var/log/onlyoffice && tar xvf /backup/onlyoffice-document-server-log.tar"
docker run --rm -v nextcloud_nc_onlyoffice_postgresql:/var/lib/postgresql -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/postgresql && tar xvf /backup/onlyoffice-document-server-postgresql.tar"
docker run --rm -v nextcloud_nc_onlyoffice_fonts:/usr/share/fonts/truetype/custom -v {windows.path}:/backup ubuntu bash -c "cd /usr/share/fonts/truetype/custom && tar xvf /backup/onlyoffice-document-server-fonts.tar"
docker run --rm -v nextcloud_nc_onlyoffice_lib:/var/lib/onlyoffice -v {windows.path}:/backup ubuntu bash -c "cd /var/lib/onlyoffice && tar xvf /backup/onlyoffice-document-server-lib.tar"
```

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