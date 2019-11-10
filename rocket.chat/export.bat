SET EXPORT_DIR=[CONFIGURE TO YOUR CWD]

docker run --rm --volumes-from rocketchat -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /app/uploads && tar cvf /backup/rocket.chat-upload.tar ."
docker run --rm --volumes-from rc_mongo -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /data/db && tar cvf /backup/rc_mongo-data-db.tar ."
docker run --rm --volumes-from rc_mongo -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /dump && tar cvf /backup/rc_mongo-dump.tar ."
docker run --rm --volumes-from rc_mongo -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /data/configdb && tar cvf /backup/rc_mongo-data-config.tar ."
docker run --rm --volumes-from rc_mongo_repl -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /data/db && tar cvf /backup/rc_mongo_repl-data-db.tar ."
docker run --rm --volumes-from rc_mongo_repl -v %EXPORT_DIR%:/backup ubuntu bash -c "cd /data/configdb && tar cvf /backup/rc_mongo_repl-data-config.tar ."
