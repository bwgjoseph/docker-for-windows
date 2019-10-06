#!/bin/bash

set -x

docker exec -u www-data nextcloud-server php occ --no-warnings config:system:get trusted_domains >> trusted_domain.tmp

if ! grep -q "nginx-server" trusted_domain.tmp; then
    TRUSTED_INDEX=$(cat trusted_domain.tmp | wc -l);
    docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set trusted_domains $TRUSTED_INDEX --value="nginx-server"
fi

rm trusted_domain.tmp

docker exec -u www-data nextcloud-server php occ --no-warnings app:install onlyoffice
docker exec -u www-data nextcloud-server php occ --no-warnings app:install spreed
docker exec -u www-data nextcloud-server php occ --no-warnings app:install quota_warning
docker exec -u www-data nextcloud-server php occ --no-warnings app:enable files_external
docker exec -u www-data nextcloud-server php occ --no-warnings app:update files_rightclick

docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice DocumentServerUrl --value="/ds-vpath/"
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice DocumentServerInternalUrl --value="http://onlyoffice-document-server/"
docker exec -u www-data nextcloud-server php occ --no-warnings config:system:set onlyoffice StorageUrl --value="http://nginx-server/"
