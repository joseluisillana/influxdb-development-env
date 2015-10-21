# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Disable synced folders (prevents an NFS error on "vagrant up")
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "docker" do |d|

# The following line terminates all ssh connections. Therefore
  # Vagrant will be forced to reconnect.
  # That's a workaround to have the docker command in the PATH
  config.vm.provision "shell", inline:
     "ps aux | grep 'sshd:' | awk '{print $2}' | xargs kill"

    # Specify a friendly name for the Docker container
    d.name = 'influxdb-container'
    
    d.build_dir = "dockerfiles/influxdb_0.9.4.2"
    d.has_ssh = true
  end
  
  config.ssh.port = 22

end
