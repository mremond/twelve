# Docker + Elixir project example

## Build and run locally

```
mix deps.get
mix release

REPLACE_OS_VARS=true NODE_NAME=node1 NODES=node2@MacBook-Pro-de-Mickael _build/dev/rel/my_app/bin/my_app console
```

## Build and run Docker image

Be careful, parameter order matters ...

```
docker build -t my_app .
docker run -it --rm -e NODE_NAME='node2' -e NODES='node1@MacBook-Pro-de-Mickael' my_app
```

## Start a cluster with Docker compose

```
docker-compose up
```

## Cluster discovery (TODO)

You can start a disco daemon in the cluster. It will register nodes
for a given cluster and return the list of existing nodes, so that the
new node can connect to them.

TODO add tools to generate twelve configuration:
- Add distillery and twelve as dependencies
- Generate Docker file
- Add vm.args
- Generate Docker-compose for two nodes
- Generate Kubernetes file
