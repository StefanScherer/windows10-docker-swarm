param ([String] $ip)

if ($ip -Eq "") {
  $ip=(Get-NetIPAddress -AddressFamily IPv4 `
     | Where-Object -FilterScript { $_.InterfaceAlias -Ne "vEthernet (HNS Internal NIC)" } `
     | Where-Object -FilterScript { $_.IPAddress -Ne "127.0.0.1" } `
     | Where-Object -FilterScript { $_.IPAddress -Ne "10.0.2.15" } `
     ).IPAddress
}

docker swarm init --listen-addr ${ip}:2377 --advertise-addr ${ip}:2377

# use Vagrant shared folder to transfer token to other managers and workers
if (!(Test-Path C:\vagrant\resources)) {
  mkdir C:\vagrant\resources
}
# docker swarm join-token manager -q | Out-File -Encoding Ascii C:\vagrant\resources\manager-token
# docker swarm join-token worker -q | Out-File -Encoding Ascii C:\vagrant\resources\worker-token
