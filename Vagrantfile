# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  config.ssh.insert_key = false
  config.ssh.private_key_path = "~/vagrantKB/keys/id_rsa"
  config.ssh.forward_agent = true
  
    # --- VM with Main.host Server ---
  config.vm.define "krmb" do |krmb|
    krmb.vm.box = "~/vagrantKB/cent.box"
    krmb.vm.synced_folder '.', '/vagrant'
  	krmb.vm.hostname = 'krmb.host'
    krmb.vm.network "public_network", ip: "192.168.0.254", bridge: "enp2s0"
    krmb.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
      vb.cpus = "2"
      vb.name = "KRMB_HOST"
    end
    krmb.vm.provision "shell",  path: "scenario.sh"
  end
end