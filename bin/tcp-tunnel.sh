#!/bin/bash
# tcp-tunnel.sh - establish a (ssh?) tcp tunnel, accessible remotely
# Usage: tunnel.sh <remote-host>
# Usage: LOCAL_PORT=45 tunnel.sh <remote-host>

ip_of_local_host() {
  /sbin/ifconfig eth0 |\
    grep 'inet addr' |\
    awk '{print $2}' |\
    cut -f 2-2 -d:
}

ip_of_host() {
  host -t a "$1" | awk '{print $4}'
}

main() {
  remote_host="$1"
  local_ip=${LOCAL_IP:-$(ip_of_local_host)}
  local_port=${LOCAL_PORT:-22}
  remote_port=${REMOTE_PORT:-42222}
  remote_ip=$(ip_of_host "$remote_host")

  ssh -R $remote_ip:$remote_port:$local_ip:$local_port $remote_host
}

main "$@"
