# https://docs.docker.com/engine/swarm/swarm-tutorial/#/open-ports-between-the-hosts
& netsh advfirewall firewall add rule name="Docker insecure TCP" dir=in action=allow protocol=TCP localport=2375
