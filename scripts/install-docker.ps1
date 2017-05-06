# https://msdn.microsoft.com/en-us/virtualization/windowscontainers/quick_start/quick_start_windows_10
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Set-ExecutionPolicy Bypass -scope Process

$version = "17.05.0-ce"

New-Item -Type Directory -Path "$($env:ProgramFiles)\docker"

Write-Host "Downloading docker-$version.zip"
$wc = New-Object net.webclient
$wc.DownloadFile("https://get.docker.com/builds/Windows/x86_64/docker-$version.zip", "$env:TEMP\docker-$version.zip")
Write-Host "Extracting docker-$version.zip"
Expand-Archive -Path "$env:TEMP\docker-$version.zip" -DestinationPath $env:ProgramFiles -Force
Remove-Item "$env:TEMP\docker-$version.zip"

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:ProgramFiles)\docker", [EnvironmentVariableTarget]::Machine)
$env:Path = $env:Path + ";$($env:ProgramFiles)\docker"
. dockerd --register-service -H npipe:// -H 0.0.0.0:2375 -G docker

Start-Service docker
