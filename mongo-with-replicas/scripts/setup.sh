#!/bin/bash

m1=mongo-1
m2=mongo-2
m3=mongo-3
port=27017

echo "###### Waiting for ${m1} instance startup.."
until mongosh --host ${m1}:${port} --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 1
done
echo "###### Working ${m1} instance found, initiating user setup & initializing rs setup.."

# setup user + pass and initialize replica sets
mongosh --host ${m1}:${port} <<EOF
var rootUser = 'admin';
var rootPassword = 'password';
var admin = db.getSiblingDB('admin');
admin.auth(rootUser, rootPassword);

var config = {
    "_id": "mgrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "${m1}:${port}",
            "priority": 2
        },
        {
            "_id": 2,
            "host": "${m2}:${port}",
            "priority": 1
        },
        {
            "_id": 3,
            "host": "${m3}:${port}",
            "priority": 1,
            "arbiterOnly": true
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF
echo "setup completed..."