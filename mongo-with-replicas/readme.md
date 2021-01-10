# Pre-setup

If you wish to create data volume and manage externally:

```
docker volume create mongo_db_primary
docker volume create mongo_configdb_primary
docker volume create mongo_db_secondary
docker volume create mongo_configdb_secondary
docker volume create mongo_db_arbiter
docker volume create mongo_configdb_arbiter
```

# Startup

Run `docker-compose up -d`

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

Launch your browser, and navigate to `http://localhost:38081`

add `127.0.0.1 mongo-primary mongo-secondary mongo-arbiter` to `hosts` file

docker exec -it mongo-primary bash
config={"_id":"rs0","members":[{"_id":0,"host":"mongo-primary:27017", "priority": 2},{"_id":1,"host":"mongo-secondary:27017"},{"_id":2,"host":"mongo-arbiter:27017", "arbiterOnly": true}]}
rs.initiate(config)

> setting higher priority allows us to force the member as PRIMARY - [force-member-to-be-primary](https://docs.mongodb.com/manual/tutorial/force-member-to-be-primary/)
> need to restart bash session and relogin to see as PRIMARY
> use rs.status() to view the role

after docker-compose down and up, need to wait a short while to let mongo-replicas-express run correctly

mongo
rs.initiate()
rs.add("mongo-secondary:27017")
rs.addArb("mongo-arbiter:27017")

echo '172.18.0.2 mongo-secondary' >> hosts
echo '172.18.0.3 mongo-arbiter' >> hosts

https://github.com/frontalnh/mongodb-replica-set
https://stackoverflow.com/questions/57123227/cannot-connect-from-node-to-mongo-replicaset-in-docker

---

docker exec mongo-primary ./scripts/setup.sh

rs.slaveOk(): This allows the current connection to allow read operations to run on secondary members

https://docs.mongodb.com/manual/core/security-internal-authentication/

https://jessequinn.info/blog/articles/mongo-docker
https://prashix.medium.com/setup-mongodb-replicaset-with-authentication-enabled-using-docker-compose-5edd2ad46a90
https://gist.github.com/harveyconnor/518e088bad23a273cae6ba7fc4643549
https://github.com/stabenfeldt/elastic-mongo
https://towardsdatascience.com/how-to-deploy-a-mongodb-replica-set-using-docker-6d0b9ac00e49


https://www.sohamkamani.com/blog/2016/06/30/docker-mongo-replica-set/
https://github.com/mongodb/specifications/blob/master/source/server-discovery-and-monitoring/server-discovery-and-monitoring.rst#clients-use-the-hostnames-listed-in-the-replica-set-config-not-the-seed-list
https://stackoverflow.com/questions/47998855/connect-to-mongodb-replica-set-running-inside-docker-with-java-windows
https://developer.mongodb.com/community/forums/t/configure-remote-access-to-mongodb-running-on-docker-with-replica-set-on-ubuntu/14042
https://github.com/compose-ex/activewriter

add to host

127.0.10.1 mongo-primary
127.0.10.2 mongo-secondary
127.0.10.3 mongo-arbiter