# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    
    config.vm.box = "centos/7"
    config.vm.box_check_update = true
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = "2"
    end

    config.ssh.insert_key = "false"
   
    config.vm.provision "shell", inline: <<-SHELL
        echo "vagrant:vagrant" | chpasswd
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd.service
        echo "192.168.10.10 log" >> /etc/hosts
        echo "192.168.10.11 web" >> /etc/hosts
        SHELL

    config.vm.define "log", primary: true do |log|
            log.vm.hostname = "log"
            log.vm.network "private_network", ip: "192.168.10.10", virtualbox__intnet: true, name: "provision_net"
        end

    config.vm.define "web", primary: true do |web|
            web.vm.hostname = "web"
            web.vm.network "private_network", ip: "192.168.10.11", virtualbox__intnet: true, name: "provision_net"
            web.vm.network "forwarded_port", guest: 80, host: 8080
            web.vm.network "forwarded_port", guest: 19531, host: 8088
        end

    config.vm.define "ansiblecontroller", primary: true do |ansiblecontroller|
            ansiblecontroller.vm.network "private_network", ip: "192.168.10.111", virtualbox__intnet: true, name: "provision_net"
            ansiblecontroller.vm.hostname = "ansiblecontroller"
                ansiblecontroller.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
                    ansible.playbook       = "provisioning/playbook.yml"
                    ansible.install        = true
                    #ansible.verbose        = true
                    ansible.limit          = "all"
                    ansible.inventory_path = "hosts"
                end
        end      
end    