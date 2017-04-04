# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.7.4"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box          = "windows_10_15063"
  config.vm.communicator = "winrm"

  config.vm.provider "hyperv" do |v|
      # v.vmname = "windows1" # Not sure if hyperv provider sets vmname == hostname or not
      v.cpus = 2
      v.memory = 2048
      v.maxmemory = 3072
      v.differencing_disk = true
  end

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.gui = true
      v.vmx["memsize"] = "3072"
      v.vmx["numvcpus"] = "2"
      v.vmx["vhv.enable"] = "TRUE"
      v.enable_vmrun_ip_lookup = false
      v.linked_clone = true
    end
  end

  subnet = "192.168.36"

  config.vm.provider :vcloud do |v, override|
    v.vapp_prefix = "windows10-docker-swarm"
    v.ip_subnet = "#{subnet}.1/255.255.255.0" # our test subnet with fixed IP adresses for everyone
    override.vm.usable_port_range = 2200..2999
    v.memory = 8192
    v.cpus = 4
    v.catalog_name = "BASEBOX-TESTING"
    v.nested_hypervisor = true
  end

  config.vm.define "sw-win-01" do |config|
    config.vm.hostname = "sw-win-01"
    config.vm.network :private_network, ip: "#{subnet}.2", gateway: "#{subnet}.1"
    config.vm.provision "shell", path: "scripts/fix-second-network.ps1", privileged: false, args: "#{subnet}.2"
    config.vm.provision "shell", path: "scripts/open-swarm-mode-ports.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/open-docker-insecure-port.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/enable-autologon.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/add-docker-group.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-winrm-delay-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-container-feature.ps1", privileged: false
    config.vm.provision "reload"
    config.vm.provision "shell", path: "scripts/set-winrm-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-experimental.ps1", privileged: false
#    config.vm.provision "shell", path: "scripts/update-nightly-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-chocolatey.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-dockertools.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-googlechrome.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/docker-swarm-init.ps1", privileged: false, args: "-ip #{subnet}.2"
  end

  config.vm.define "sw-win-02" do |config|
    config.vm.hostname = "sw-win-02"
    config.vm.network :private_network, ip: "#{subnet}.3", gateway: "#{subnet}.1"
    config.vm.provision "shell", path: "scripts/fix-second-network.ps1", privileged: false, args: "#{subnet}.3"
    config.vm.provision "shell", path: "scripts/open-swarm-mode-ports.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/enable-autologon.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/add-docker-group.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-winrm-delay-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-container-feature.ps1", privileged: false
    config.vm.provision "reload"
    config.vm.provision "shell", path: "scripts/set-winrm-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-experimental.ps1", privileged: false
#    config.vm.provision "shell", path: "scripts/update-nightly-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-chocolatey.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-dockertools.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/docker-swarm-join.ps1", privileged: false, args: "-managerip #{subnet}.2 -ip #{subnet}.3"
  end

  config.vm.define "sw-win-03" do |config|
    config.vm.hostname = "sw-win-03"
    config.vm.network :private_network, ip: "#{subnet}.4", gateway: "#{subnet}.1"
    config.vm.provision "shell", path: "scripts/fix-second-network.ps1", privileged: false, args: "#{subnet}.4"
    config.vm.provision "shell", path: "scripts/open-swarm-mode-ports.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/enable-autologon.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/add-docker-group.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-winrm-delay-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-container-feature.ps1", privileged: false
    config.vm.provision "reload"
    config.vm.provision "shell", path: "scripts/set-winrm-autostart.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/set-experimental.ps1", privileged: false
#    config.vm.provision "shell", path: "scripts/update-nightly-docker.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-chocolatey.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/install-dockertools.ps1", privileged: false
    config.vm.provision "shell", path: "scripts/docker-swarm-join.ps1", privileged: false, args: "-managerip #{subnet}.2 -ip #{subnet}.3"
  end
end
