# Bitcoind Multi Node Docker Setup (Regtest)

Spin up 3 bitcoind nodes in regtest mode.

## Requirements

Docker or Docker Desktop installed on your machine.

## Usage

Build the image and start up the nodes.

```shell
$ make docker.up.build
```

Exec into one of the containers.

```shell
$ make docker.exec.miner
```
