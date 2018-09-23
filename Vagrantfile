# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.keys_only = false
  #config.vm.synced_folder '.', '/vagrant'
  #config.vm.boot_timeout
  config.ssh.insert_key = false
  #config.vm.box = "centos/7"
  config.ssh.private_key_path = File.expand_path ('~/.ssh/id_rsa')
  config.ssh.forward_agent = true

    # --- VM with Main.host Server ---
  config.vm.define "main" do |main|
    main.vm.box = "~/vagrantKB/CentOS7.box"
    main.vm.synced_folder '.', '/vagrant'
  	#main.vm.box = "centos/7"
    main.vm.hostname = 'main.host'
    #main.vm.network "public_network", :adapter=>1, ip: "192.168.1.254", bridge: "wlp4s0"
    main.vm.network "public_network", ip: "192.168.1.254", bridge: "wlp4s0"
    #main.vm.network "private_network", ip: "192.168.0.254"
    main.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
      vb.name = "MAIN_HOST"
    end
    main.vm.provision "shell",  path: "scenario.sh"
  end
end