docker volume create nextcloud_nc_server_appdata
docker volume create nextcloud_nc_maria_data
docker volume create nextcloud_nc_onlyoffice_data
docker volume create nextcloud_nc_onlyoffice_log
docker volume create nextcloud_nc_onlyoffice_postgresql
docker volume create nextcloud_nc_onlyoffice_fonts
docker volume create nextcloud_nc_onlyoffice_lib

docker run --rm -v nextcloud_nc_server_appdata:/var/www/html -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/www/html && tar xvf /backup/nextcloud-server-data.tar"
docker run --rm -v nextcloud_nc_maria_data:/var/lib/mysql -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/lib/mysql && tar xvf /backup/nextcloud-mariadb-data.tar"
docker run --rm -v nextcloud_nc_onlyoffice_data:/var/www/onlyoffice/Data -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/www/onlyoffice/Data && tar xvf /backup/onlyoffice-document-server-data.tar"
docker run --rm -v nextcloud_nc_onlyoffice_log:/var/log/onlyoffice -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/log/onlyoffice && tar xvf /backup/onlyoffice-document-server-log.tar"
docker run --rm -v nextcloud_nc_onlyoffice_postgresql:/var/lib/postgresql -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/lib/postgresql && tar xvf /backup/onlyoffice-document-server-postgresql.tar"
docker run --rm -v nextcloud_nc_onlyoffice_fonts:/usr/share/fonts/truetype/custom -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /usr/share/fonts/truetype/custom && tar xvf /backup/onlyoffice-document-server-fonts.tar"
docker run --rm -v nextcloud_nc_onlyoffice_lib:/var/lib/onlyoffice -v Z://Development//Docker//nextcloud//backup:/backup ubuntu bash -c "cd /var/lib/onlyoffice && tar xvf /backup/onlyoffice-document-server-lib.tar"