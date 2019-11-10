docker volume create rocketchat-old_rc_uploads
docker volume create rocketchat-old_rc_mongo_db
docker volume create rocketchat-old_rc_mongo_dump
docker volume create rocketchat-old_rc_mongo_configdb
docker volume create rocketchat-old_rc_mongo_repl_db
docker volume create rocketchat-old_rc_mongo_repl_configdb

SET IMPORT_DIR=[CONFIGURE TO YOUR CWD]

docker run --rm -v rocketchat-old_rc_uploads:/app/uploads -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /app/uploads && tar xvf /backup/rocket.chat-upload.tar"
docker run --rm -v rocketchat-old_rc_mongo_db:/data/db -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /data/db && tar xvf /backup/rc_mongo-data-db.tar"
docker run --rm -v rocketchat-old_rc_mongo_dump:/dump -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /dump && tar xvf /backup/rc_mongo-dump.tar"
docker run --rm -v rocketchat-old_rc_mongo_configdb:/data/configdb -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /data/configdb && tar xvf /backup/rc_mongo-data-config.tar"
docker run --rm -v rocketchat-old_rc_mongo_repl_db:/data/db -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /data/db && tar xvf /backup/rc_mongo_repl-data-db.tar"
docker run --rm -v rocketchat-old_rc_mongo_repl_configdb:/data/configdb -v %IMPORT_DIR%:/backup ubuntu bash -c "cd /data/configdb && tar xvf /backup/rc_mongo_repl-data-config.tar"