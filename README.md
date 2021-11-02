# Bitcoind Multi Node Docker Setup (Regtest)

This setup runs 4 bitcoind nodes in regtest with non persistent storage.

## Requirements

Docker or Docker Desktop installed on your machine.

## Usage

Build the image from Dockerfile and start up the nodes.

```shell
$ docker-compose -p bitcoind build
$ docker-compose -p bitcoind up -d
```

Exec into one of the containers

```shell
$ docker exec -it node1 /bin/bash
```
