# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
 
	config.vm.define "pxe", primary: true do |pxe|
		pxe.vm.box = "centos/8.2"
		pxe.vm.hostname = "pxe"
			pxe.vm.provider "virtualbox" do |vb|
				vb.memory = "1024"
				vb.cpus = "2"
				vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			end
		pxe.vm.network :private_network, 
                     ip: "192.168.34.10", 
                     virtualbox__intnet: 'pxenet'
		pxe.ssh.insert_key = false
		pxe.vm.provision "shell", path: "setup_pxe.sh"
		
	end
	
	
	config.vm.define "client", primary: true do |client|
		client.vm.box = "centos/8.2"
		client.vm.network "private_network", ip: "192.168.34.11"
		client.vm.hostname = "client"
			client.vm.provider "virtualbox" do |vb|
				vb.memory = "2048"
				vb.cpus = "2"
				vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
				vb.customize [
					  'modifyvm', :id,
					  '--nic1', 'intnet',
					  '--intnet1', 'pxenet',
					  '--nic2', 'nat',
					  '--boot1', 'net',
					  '--boot2', 'none',
					  '--boot3', 'none',
					  '--boot4', 'none'
					]
			end
		client.ssh.insert_key = false
		
		
	end
	
end
	
	
	
	
