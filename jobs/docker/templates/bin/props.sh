#!/bin/bash

# Directory to store the Docker configuration files
export DOCKER_CONF_DIR=${JOB_DIR}/config

# Directory to store the Docker logs
export DOCKER_LOG_DIR=${LOG_DIR}

# Directory to store the Docker process IDs
export DOCKER_PID_DIR=${RUN_DIR}

# Directory to store the Docker data files
export DOCKER_STORE_DIR=${STORE_DIR}

# Directory to store the Docker temp files
export DOCKER_TMP_DIR=${TMP_DIR}

# User which will own the Docker services
export DOCKER_USER="<%= p('user') %>"

# Group which will own the Docker services
export DOCKER_GROUP="<%= p('group') %>"

<% if_p('listen_address', 'listen_port') do |address, port| %>
# TCP Address/Port where Docker daemon will listen to
export DOCKER_TCP="--host tcp://<%= address %>:<%= port %>"
<% end %>

<% if_p('bridge', 'cidr_prefix') do |bridge, cidr_prefix| %>
# Attach containers to a network bridge
export DOCKER_BRIDGE="--bridge=<%= bridge %>"
export DOCKER_BRIDGE_NAME="<%= bridge %>"
export DOCKER_BRIDGE_CIDR="<%= cidr_prefix %>.<%= index %>.1/24"
<% end %>

# Enable debug mode
export DOCKER_DEBUG="--debug=<%= p('debug') %>"

<% if_p('default_gateway') do |default_gateway| %>
# Container default gateway IPv4 address
export DOCKER_DEFAULT_GATEWAY="<%= default_gateway %>"
<% end %>

<% if_p('default_gateway_v6') do |default_gateway_v6| %>
# Container default gateway IPv6 address
export DOCKER_DEFAULT_GATEWAY_V6="<%= default_gateway_v6 %>"
<% end %>

<% if_p('default_ulimits') do |default_ulimits| %>
<% default_ulimits_list = default_ulimits.map { |default_ulimit| "--default-ulimit=#{default_ulimit}" }.join(' ') %>
# Set default ulimits for containers
export DOCKER_DEFAULT_ULIMITS="<%= default_ulimits_list %>"
<% end %>

<% if_p('dns_domains') do |dns_domains| %>
<% dns_domains_list = dns_domains.map { |dns_domain| "--dns-search=#{dns_domain}" }.join(' ') %>
# Array of DNS search domains to be used by Docker
export DOCKER_DNS_DOMAINS="<%= dns_domains_list %>"
<% end %>

<% if_p('dns_servers') do |dns_servers| %>
<% dns_servers_list = dns_servers.map { |dns_server| "--dns=#{dns_server}" }.join(' ') %>
# Array of DNS servers to be used by Docker
export DOCKER_DNS_SERVERS="<%= dns_servers_list %>"
<% end %>

<% if_p('exec_options') do |exec_options| %>
<% exec_options_list = exec_options.map { |exec_option| "--exec-opt=#{exec_option}" }.join(' ') %>
# Set exec driver options
export DOCKER_EXEC_OPTIONS="<%= exec_options_list %>"
<% end %>

# Allow unrestricted inter-container and Docker daemon host communication
export DOCKER_ICC="--icc=<%= p('icc') %>"

<% if_p('insecure_registries') do |insecure_registries| %>
<% insecure_registries_list = insecure_registries.map { |insecure_registry| "--insecure-registry=#{insecure_registry}" }.join(' ') %>
# Array of insecure registries
export DOCKER_INSECURE_REGISTRIES="<%= insecure_registries_list %>"
<% end %>

# Enable net.ipv4.ip_forward and IPv6 forwarding
export DOCKER_IPFORWARD="--ip-forward=<%= p('ip_forward') %>"

# Enable IP masquerading for bridge's IP range
export DOCKER_IPMASQ="--ip-masq=<%= p('ip_masq') %>"

# Enable Docker addition of iptables rules
export DOCKER_IPTABLES="--iptables=<%= p('iptables') %>"

# Enable IPv6 networking
export DOCKER_IPV6="--ipv6=<%= p('ipv6') %>"

# Set the logging level
export DOCKER_LOG_LEVEL="--log-level=<%= p('log_level') %>"

<% if_p('labels') do |labels| %>
<% labels_list = labels.map { |label| "--label=#{label}" }.join(' ') %>
# Array of key=value labels for the daemon
export DOCKER_LABELS="<%= labels_list %>"
<% end %>

<% if_p('mtu') do |mtu| %>
# Set the containers network MTU
export DOCKER_MTU="--mtu=<%= mtu %>"
<% end %>

<% if_p('registry_mirrors') do |registry_mirrors| %>
<% registry_mirrors_list = registry_mirrors.map { |registry_mirror| "--registry-mirror=#{registry_mirror}" }.join(' ') %>
# Array of preferred Docker registry mirrors
export DOCKER_REGISTRY_MIRRORS="<%= registry_mirrors_list %>"
<% end %>

# Enable selinux support
export DOCKER_SELINUX_ENABLED="--selinux-enabled=<%= p('selinux_enable') %>"

<% if_p('storage_driver') do |storage_driver| %>
# Use a specific storage driver
export DOCKER_STORAGE_DRIVER="--storage-driver=<%= storage_driver %>"
<% end %>

<% if_p('storage_options') do |storage_options| %>
<% storage_options_list = storage_options.map { |storage_option| "--storage-opt=#{storage_option}" }.join(' ') %>
# Array of storage driver options
export DOCKER_STORAGE_OPTIONS="<%= storage_options_list %>"
<% end %>

# Always use TLS
export DOCKER_TLS_VERIFY_ENABLED="--tlsverify"
export DOCKER_TLS_CACERT="--tlscacert=${DOCKER_CONF_DIR}/ca"
export DOCKER_TLS_CERT="--tlscert=${DOCKER_CONF_DIR}/cert"
export DOCKER_TLS_KEY="--tlskey=${DOCKER_CONF_DIR}/private_key"

# Use userland proxy for loopback traffic
export DOCKER_USERLAND_PROXY="--userland-proxy=<%= p('userland_proxy') %>"

<% if_p('cluster_store') do |cluster_store| %>
export DOCKER_CLUSTER_STORE="--cluster-store=<%= cluster_store %> --cluster-advertise=<%= "#{spec.address}:#{p('listen_port')}" %>"
<% end %>

# Proxy configuration
<% if_p('env.http_proxy') do |http_proxy| %>
export HTTP_PROXY="<%= http_proxy %>"
export http_proxy="<%= http_proxy %>"
<% end %>

<% if_p('env.https_proxy') do |https_proxy| %>
export HTTPS_PROXY="<%= https_proxy %>"
export https_proxy="<%= https_proxy %>"
<% end %>

<% if_p('env.no_proxy') do |no_proxy| %>
export NO_PROXY="<%= no_proxy %>"
export no_proxy="<%= no_proxy %>"
<% end %>
