# --Open TCP/UDP ports required by Swarm--
# These are the firewall rules required by swarm mode (see https://docs.docker.com/engine/swarm/swarm-tutorial/#/open-protocols-and-ports-between-the-hosts)
New-NetFirewallRule -DisplayName "Swarm TCP: Allow inbound on ports 2377,7946,4789" -Direction Inbound –LocalPort 2377,7946,4789 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Swarm TCP: Allow outbound on ports 2377,7946,4789" -Direction Outbound –LocalPort 2377,7946,4789 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Swarm UDP: Allow inbound on ports 7946,4789" -Direction Inbound –LocalPort 7946,4789 -Protocol UDP -Action Allow
New-NetFirewallRule -DisplayName "Swarm UDP: Allow outbound on ports 7946,4789" -Direction Outbound –LocalPort 7946,4789 -Protocol UDP -Action Allow
