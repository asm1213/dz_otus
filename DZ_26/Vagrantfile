# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    
    # if Vagrant.has_plugin?("vagrant-vbguest")
    #     config.vbguest.auto_update = false
    #   end

    config.vm.box = "centos/7"
    config.vm.box_check_update = true
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = "1"
    end

    config.ssh.insert_key = "false"
   
    config.vm.provision "shell", inline: <<-SHELL
        echo "vagrant:vagrant" | chpasswd
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd.service
        echo "192.168.10.10 master" >> /etc/hosts
        echo "192.168.10.11 slave" >> /etc/hosts
        echo "192.168.10.111 ansiblecontroller" >> /etc/hosts
        SHELL

    config.vm.define "master", primary: true do |master|
            master.vm.hostname = "master"
            master.vm.network "private_network", ip: "192.168.10.10", virtualbox__intnet: true, name: "provision_net"
        end

    config.vm.define "slave", primary: true do |slave|
            slave.vm.hostname = "slave"
            slave.vm.network "private_network", ip: "192.168.10.11", virtualbox__intnet: true, name: "provision_net"
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
                    #ansible.galaxy_role_file = "provisioning/requirements.yml"
                    #ansible.galaxy_roles_path = "/etc/ansible/collections"
                    #ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
                end
        end      
end    