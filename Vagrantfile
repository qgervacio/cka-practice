# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  create(config, "master",   "192.167.25.1", 2)
  create(config, "worker",   "192.167.25.2", 2)
  create(config, "balancer", "192.167.25.3", 1)
  create(config, "client",   "192.167.25.4", 1)
end

def create(config, name, ip, count)
  (0...count).each do |i|
    n = "#{name}#{i}"
    config.vm.define n do |node|
      node.vm.box = "ubuntu/xenial64"
      node.vm.hostname = n

      node.vm.network "private_network",
        ip: "#{ip}#{i}"

      node.vm.provider "virtualbox" do |spec|
        spec.memory = 2048
      end

      # let's to it the hard way
      node.vm.provision "shell", path: "scripts/000.sh"

      # all nodes
      # node.vm.provision "shell", path: "scripts/001.sh"

      # master only
      # if name.include? "master"
      #   node.vm.provision "shell", path: "scripts/002.sh"
      # end
    end
  end
end
