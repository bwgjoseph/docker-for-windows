# Oracle Database

- Clone [oracle/docker-images](https://github.com/oracle/docker-images)
- Download [linux x84-64](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html)
- Copy to `OracleDatabase/SingleInstance/dockerfiles/19.3.0`
- Navigate to `OracleDatabase/SingleInstance/dockerfiles`
- Run `./buildContainerImage.sh -v 19.3.0 -t oracledb:19.3.0-ee -e`
- Run `docker-compose up -d`
- Access [UI](https://localhost:5500/em/)
  - sys / 5m0J9FtPEhs=1 / ORCLPDB1
- Run `docker run -it --rm oracledb:19.3.0-ee sh`
  - Enter `sqlplus` > `sys@ORCLPDB1 as sysdba` > `5m0J9FtPEhs=1`
  - Run the following command after login:
    - ALTER SESSION SET container = ORCLPDB1;
    - CREATE USER CS_DEV IDENTIFIED BY password1;
    - GRANT CONNECT, RESOURCE, DBA TO CS_DEV;
    - GRANT CREATE SESSION TO CS_DEV;
    - GRANT UNLIMITED TABLESPACE TO CS_DEV;

## Note

By default, when `Oracle` is first initialized, it should have ran `setup/01_create_user.sql` and created the user but for some unknown reason, the script runs, and have no visible errors but the user does not seem to be actually created even though the logs says it did. Hence, for now, have to run the command manually to create the user

## Resources

- [OracleDatabase/SingleInstance](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md)
- [introduction-to-oracle-database.html](https://docs.oracle.com/en/database/oracle/oracle-database/19/cncpt/introduction-to-oracle-database.html#GUID-A42A6EF0-20F8-4F4B-AFF7-09C100AE581E)
- [how-to-setup-docker-container-oracle-database-19c-for-liferay-development-environment](https://www.dontesta.it/en/2020/03/15/how-to-setup-docker-container-oracle-database-19c-for-liferay-development-environment/)
- [oracle-db19c-com-docker](https://www.oracle.com/br/technical-resources/articles/database-performance/oracle-db19c-com-docker.html)
- [deliver-oracle-database-18c-express-edition-in-containers](https://blogs.oracle.com/oraclemagazine/deliver-oracle-database-18c-express-edition-in-containers)
- [maven-central-guide](https://www.oracle.com/database/technologies/maven-central-guide.html)