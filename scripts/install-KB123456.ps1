# --Enable test-signing--
bcdedit -set testsigning on

# --If old KB is installed, uninstall it--
# This statement checks whether or not this machine has the original swarm/overlay package installed.
# If so, the package is uninstalled before the new package is installed.
if (Get-HotFix | where HotfixID -match "888882") {
wusa /uninstall /kb:888882 /quiet
}

# --Install new swarm/overlay package--
Start-Process -FilePath C:\vagrant\resources\Windows10.0-KB123456-x64-InstallForTestingPurposesOnly.exe -ArgumentList /norestart, /q -Wait
