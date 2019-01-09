# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  #config.vm.synced_folder '.', '/vagrant'
  #config.vm.boot_timeout
  config.ssh.insert_key = false
  #config.vm.box = "centos/7"
  #config.ssh.private_key_path = File.expand_path ('~/vagrantKB/keys/id_rsa')
  config.ssh.private_key_path = "~/vagrantKB/keys/id_rsa"
  config.ssh.forward_agent = true
  #config.disksize.size = '50GB'

    # --- VM with Main.host Server ---
  config.vm.define "krmb" do |krmb|
    krmb.vm.box = "~/vagrantKB/cent.box"
    krmb.vm.synced_folder '.', '/vagrant'
  	#main.vm.box = "centos/7"
    krmb.vm.hostname = 'krmb.host'
    #main.vm.network "public_network", :adapter=>1, ip: "192.168.1.254", bridge: "wlp4s0"
    krmb.vm.network "public_network", ip: "192.168.0.254", bridge: "enp2s0"
    #main.vm.network "private_network", ip: "192.168.0.254"
    krmb.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
      vb.cpus = "4"
      vb.name = "KRMB_HOST"
    end
    krmb.vm.provision "shell",  path: "scenario.sh"
  end
end