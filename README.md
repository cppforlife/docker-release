## docker-release

```
$ export DOCKER_HOST=tcp://10.244.1.2:4243
$ docker save swarm:1.1.0 > blobs/docker/swarm-1.1.0.tar
```

```
$ docker ps --all | grep etcd
a48b1b9f5e0d        swarm:1.1.0         /swarm manage etcd:/   0.0.0.0:32768->2375/tcp

$ bosh run-errand bootstrap_swarm
$ export DOCKER_HOST=tcp://10.244.1.2:32768
$ docker ps --all
```

## TODO

- mark nodes by AZ, and custom tags, elastic IPs, ELBs?
