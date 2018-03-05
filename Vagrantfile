# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  #config.vm.box_version = "20180227.0.1"
  config.vm.hostname = "vagrant-teamcity-server.local"
  config.vm.provider "virtualbox" do |v|
    #v.name = "vagrant-teamcity-server"
    v.memory = 4096
    v.cpus = 2
  end
  
  config.vm.network "forwarded_port", guest: 8111, host: 8111

  #config.vm.provision "shell" do |s|
  #  s.path = "scripts/prepare-server.sh"
  #  #s.args = ["web"] # hostname
  #end

end