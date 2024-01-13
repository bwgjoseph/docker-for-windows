# Blog

See this [blogpost](https://bwgjoseph.com/setting-up-mongodb-with-replicas-for-local-development) for detailed explanation

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

## [Optional] Create Keyfile

In order to perform internal authentication, it requires `keyfile`

> Install [Win64 OpenSSL v3.2.0](https://slproweb.com/products/Win32OpenSSL.html) if you don't have in Windows machine. Otherwise, can use WSL to generate.

Run

```bash
cd scripts
openssl rand -base64 756 > mongo-replica.key
```

A keyfile has been pre-created

# Startup

Run `docker-compose up -d`

Note: Ensure you do not have another running instance of mongodb (at least not on 27017 port). Personally, I have issue connecting to replicas when another instance is running.

It will be ready once `mongo-setup` docker finished running to configure the replicas

## Verify

To ensure the replicas has been setup and configured correctly

```bash
docker exec -it mongo-1 bash
mongosh --host mongo-1:27017 --username admin --password password
rs.status()
```

You should see the following message

```json
{
  set: 'mgrs',
  date: ISODate('2024-01-13T07:27:00.442Z'),
  myState: 1,
  term: Long('1'),
  syncSourceHost: '',
  syncSourceId: -1,
  heartbeatIntervalMillis: Long('2000'),
  majorityVoteCount: 2,
  writeMajorityCount: 2,
  votingMembersCount: 3,
  writableVotingMembersCount: 2,
  optimes: {
    lastCommittedOpTime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
    lastCommittedWallTime: ISODate('2024-01-13T07:26:57.042Z'),
    readConcernMajorityOpTime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
    appliedOpTime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
    durableOpTime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
    lastAppliedWallTime: ISODate('2024-01-13T07:26:57.042Z'),
    lastDurableWallTime: ISODate('2024-01-13T07:26:57.042Z')
  },
  lastStableRecoveryTimestamp: Timestamp({ t: 1705130807, i: 1 }),
  electionCandidateMetrics: {
    lastElectionReason: 'electionTimeout',
    lastElectionDate: ISODate('2024-01-13T07:24:06.796Z'),
    electionTerm: Long('1'),
    lastCommittedOpTimeAtElection: { ts: Timestamp({ t: 1705130636, i: 1 }), t: Long('-1') },
    lastSeenOpTimeAtElection: { ts: Timestamp({ t: 1705130636, i: 1 }), t: Long('-1') },
    numVotesNeeded: 2,
    priorityAtElection: 2,
    electionTimeoutMillis: Long('10000'),
    numCatchUpOps: Long('0'),
    newTermStartDate: ISODate('2024-01-13T07:24:06.962Z'),
    wMajorityWriteAvailabilityDate: ISODate('2024-01-13T07:24:07.486Z')
  },
  members: [
    {
      _id: 1,
      name: 'mongo-1:27017',
      health: 1,
      state: 1,
      stateStr: 'PRIMARY',
      uptime: 189,
      optime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-01-13T07:26:57.000Z'),
      lastAppliedWallTime: ISODate('2024-01-13T07:26:57.042Z'),
      lastDurableWallTime: ISODate('2024-01-13T07:26:57.042Z'),
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      electionTime: Timestamp({ t: 1705130646, i: 1 }),
      electionDate: ISODate('2024-01-13T07:24:06.000Z'),
      configVersion: 1,
      configTerm: 1,
      self: true,
      lastHeartbeatMessage: ''
    },
    {
      _id: 2,
      name: 'mongo-2:27017',
      health: 1,
      state: 2,
      stateStr: 'SECONDARY',
      uptime: 184,
      optime: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
      optimeDurable: { ts: Timestamp({ t: 1705130817, i: 1 }), t: Long('1') },
      optimeDate: ISODate('2024-01-13T07:26:57.000Z'),
      optimeDurableDate: ISODate('2024-01-13T07:26:57.000Z'),
      lastAppliedWallTime: ISODate('2024-01-13T07:26:57.042Z'),
      lastDurableWallTime: ISODate('2024-01-13T07:26:57.042Z'),
      lastHeartbeat: ISODate('2024-01-13T07:26:58.867Z'),
      lastHeartbeatRecv: ISODate('2024-01-13T07:26:59.866Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: 'mongo-1:27017',
      syncSourceId: 1,
      infoMessage: '',
      configVersion: 1,
      configTerm: 1
    },
    {
      _id: 3,
      name: 'mongo-3:27017',
      health: 1,
      state: 7,
      stateStr: 'ARBITER',
      uptime: 184,
      lastHeartbeat: ISODate('2024-01-13T07:26:58.857Z'),
      lastHeartbeatRecv: ISODate('2024-01-13T07:26:58.870Z'),
      pingMs: Long('0'),
      lastHeartbeatMessage: '',
      syncSourceHost: '',
      syncSourceId: -1,
      infoMessage: '',
      configVersion: 1,
      configTerm: 1
    }
  ],
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1705130817, i: 1 }),
    signature: {
      hash: Binary.createFromBase64('XCZgbST9v8BNTtiZazB94x2AaPA=', 0),
      keyId: Long('7323480359977353221')
    }
  },
  operationTime: Timestamp({ t: 1705130817, i: 1 })
}
```

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

If you wish to connect to the instance with replicas defined in the uri, you have to add `127.0.0.1 mongo-1 mongo-2 mongo-3` to Windows `hosts` file.

# Reference

- https://github.com/docker-library/mongo/issues/475
- https://www.mongodb.com/docs/manual/tutorial/deploy-replica-set-with-keyfile-access-control/
- https://docs.mongodb.com/manual/core/security-internal-authentication/
- https://docs.mongodb.com/manual/tutorial/force-member-to-be-primary/
- https://prashix.medium.com/setup-mongodb-replicaset-with-authentication-enabled-using-docker-compose-5edd2ad46a90
- https://github.com/stabenfeldt/elastic-mongo
- https://gist.github.com/harveyconnor/518e088bad23a273cae6ba7fc4643549
- https://towardsdatascience.com/how-to-deploy-a-mongodb-replica-set-using-docker-6d0b9ac00e49
- https://www.sohamkamani.com/blog/2016/06/30/docker-mongo-replica-set/
- https://developer.mongodb.com/community/forums/t/configure-remote-access-to-mongodb-running-on-docker-with-replica-set-on-ubuntu/14042
- https://www.mongodb.com/community/forums/t/unable-to-connect-using-replicas-uri-docker-setup/10137
- https://stackoverflow.com/questions/55916275/docker-compose-to-create-replication-in-mongodb
- https://stackoverflow.com/questions/74429226/how-to-connect-to-mongodb-replicaset-k8s-using-compass
