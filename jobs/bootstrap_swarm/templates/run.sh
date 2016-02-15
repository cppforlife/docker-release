#!/bin/bash

set -e -x

export PATH=/var/vcap/packages/docker/bin:$PATH

export DOCKER_HOST=tcp://<%= p("bootstrap_swarm.listen_address") %>:<%= p("bootstrap_swarm.host_port") %>

docker load < /var/vcap/packages/docker_swarm/swarm-1.1.0.tar

docker run -p <%= p("bootstrap_swarm.listen_port") %> -d swarm:1.1.0 manage \
	<%= p("bootstrap_swarm.cluster_store") %>

<% p("bootstrap_swarm.hosts").each do |host| %>
docker run -d swarm:1.1.0 join --addr <%= host %>:<%= p("bootstrap_swarm.host_port") %> \
	<%= p("bootstrap_swarm.cluster_store") %>
<% end %>
