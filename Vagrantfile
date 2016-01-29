# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 80

  config.vm.network "private_network", ip: "192.168.88.88"

  config.vm.synced_folder "/Users/bruno/Code/", "/var/www", create: true, :owner => "vagrant", :group => "www-data", :mount_options => ["dmode=775", "fmode=664"]

   config.vm.provider "virtualbox" do |vb|
     vb.memory = "512"
     vb.cpus = "1"
  end

  config.vm.provision "shell" do |s|
    s.path = "setup.sh"
  end

end
