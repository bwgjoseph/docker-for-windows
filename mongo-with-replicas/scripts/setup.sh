#!/bin/bash

echo "Starting replica set initialize"
until mongo --host mongo-primary --eval "print(\"waited for connection\")"
do
    sleep 2
done
echo "Connection finished"
echo "Creating replica set"

mongo --host mongo-primary:27017 <<EOF
    var config = {
        "_id": "rs0",
        "members": [
            {
                "_id": 0,
                "host": "mongo-primary:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "mongo-secondary:27017",
            },
            {
                "_id": 2,
                "host": "mongo-arbiter:27017",
                "arbiterOnly": true
            }
        ]
    };
    rs.initiate(config, { force: true });
    rs.reconfig(config, { force: true });
    rs.slaveOk();
EOF