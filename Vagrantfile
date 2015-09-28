# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.1"
   #config.vm.network "private_network", type: "dhcp"
   config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "shell", path: "vagrant_config/scripts/centos_7_x.sh"
  
  #config.vm.synced_folder ".", "/var/www/symfony", type: "nfs"
  config.vm.synced_folder ".", "/var/www/symfony", :owner => 48, :group => 48

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "vagrant_config/manifests"
    puppet.manifest_file  = "site.pp"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  
end
