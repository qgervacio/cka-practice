# -*- mode: ruby -*-
# vi: set ft=ruby :

# these IPs may vary
Vagrant.configure("2") do |config|
  create(config, "master",   "192.168.56.1", 1)
  create(config, "worker",   "192.168.57.2", 2)
  # create(config, "client",   "192.168.58.3", 1)
  # create(config, "balancer", "192.168.59.4", 1)
end

def create(config, name, ip, count)
  (0...count).each do |i|
    n = "#{name}#{i}"
    config.vm.define n do |node|
      node.vm.box = "ubuntu/impish64"
      node.vm.hostname = n

      node.vm.network "private_network",
        ip: "#{ip}#{i}"

      node.vm.provider "virtualbox" do |spec|
        spec.memory = 2048
      end

      # let's do it kinda the hard way
      node.vm.provision "shell", path: "scripts/000.sh"

      # all nodes
      node.vm.provision "shell", path: "scripts/001.sh"

      # master only
      if name.include? "master"
        node.vm.provision "shell", path: "scripts/002.sh"
      end
    end
  end
end
