#!/bin/bash

<% docker = link("docker") %>

set -e -x

export PATH=/var/vcap/packages/docker/bin:$PATH

# Connect to a Docker host that will run single swarm container
# todo pick bootstrap instance
# todo should really run swarm cluster
export DOCKER_HOST=tcp://<%= docker.instances.first.address %>:<%= docker.p("listen_port") %>

docker load < /var/vcap/packages/docker_swarm/swarm-1.1.0.tar

docker run -p <%= p("listen_port") %> -d swarm:1.1.0 manage <%= p("cluster_store") %>

# todo run join commands on each Docker host
<% docker.instances.each do |instance| %>
docker run -d swarm:1.1.0 join --addr <%= instance.address %>:<%= docker.p("listen_port") %> <%= p("cluster_store") %>
<% end %>
