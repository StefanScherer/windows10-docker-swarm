# Demo for Windows 10 overlay network

See blog post [Getting started with Docker Swarm-mode on Windows 10](https://stefanscherer.github.io/docker-swarm-mode-windows10/)

```powershell
./create-network.ps1
./start-whoami.ps1
./start-askthem.ps1
docker service logs askthem
```
