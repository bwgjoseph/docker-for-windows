SET EXPORT_DIR=[CONFIGURE TO YOUR CWD]

docker run --rm --volumes-from nextcloud-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/www/html && tar cvf /backup/nextcloud-server-data.tar ."
docker run --rm --volumes-from nextcloud-mariadb -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/lib/mysql && tar cvf /backup/nextcloud-mariadb-data.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/www/onlyoffice/Data && tar cvf /backup/onlyoffice-document-server-data.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/log/onlyoffice && tar cvf /backup/onlyoffice-document-server-log.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/lib/postgresql && tar cvf /backup/onlyoffice-document-server-postgresql.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /usr/share/fonts/truetype/custom && tar cvf /backup/onlyoffice-document-server-fonts.tar ."
docker run --rm --volumes-from onlyoffice-document-server -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /var/lib/onlyoffice && tar cvf /backup/onlyoffice-document-server-lib.tar ."