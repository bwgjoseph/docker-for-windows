#!/bin/bash

echo "Checking for connection"
echo "args" $@
until mongo --host mongo --eval "print(\"waited for connection\")"
do
    sleep 2
done
echo "Connection ready"
echo "Starting data-seeding"

# Default mode is `insert`, any existing data in db with matching `_id` will be preserved, non matching `_id` will be inserted
# If want to drop and reinserted everything, add `--drop` arg before `--file`
mongoimport --username $1 --password $2 mongodb://mongo:27017/$3?authSource=admin --collection=users --file=./scripts/users.json