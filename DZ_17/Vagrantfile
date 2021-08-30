# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :inetRouter => {
        :box_name => "centos/7",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.255.1', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "router-net"},
                ]
  },
  :centralRouter => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.248", virtualbox__intnet: "router-net"},
                   {ip: '192.168.0.1', adapter: 3, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
                   # {ip: '192.168.0.33', adapter: 4, netmask: "255.255.255.240", virtualbox__intnet: "hw-net"},
				   {ip: '192.168.3.1', adapter: 6, netmask: "255.255.255.0", virtualbox__intnet: "router-net1"},
                   # {ip: '192.168.0.65', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "mgt-net"},
                ]
  },
  
  :centralServer => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.0.2', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
                   #{adapter: 3, auto_config: false, virtualbox__intnet: true},
                   #{adapter: 4, auto_config: false, virtualbox__intnet: true},
                ]
  },
  :office1Server => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.2.65', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "testservers"},
                   #{adapter: 3, auto_config: false, virtualbox__intnet: true},
                   #{adapter: 4, auto_config: false, virtualbox__intnet: true},
                ]
  },
  :office1Router => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.3.2', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "router-net1"},
                   {ip: '192.168.2.126', adapter: 3, netmask: "255.255.255.192", virtualbox__intnet: "testservers"},
                 #  {ip: '192.168.0.33', adapter: 4, netmask: "255.255.255.240", virtualbox__intnet: "hw-net"},
                   #{ip: '192.168.0.65', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "mgt-net"},
                ]
  },
  :office2Server => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.1.129', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "testservers"},
                   #{adapter: 3, auto_config: false, virtualbox__intnet: true},
                   #{adapter: 4, auto_config: false, virtualbox__intnet: true},
                ]
  },
  :office2Router => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.3.3', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "router-net1"},
                   {ip: '192.168.1.190', adapter: 3, netmask: "255.255.255.192", virtualbox__intnet: "testservers"},
                 #  {ip: '192.168.0.33', adapter: 4, netmask: "255.255.255.240", virtualbox__intnet: "hw-net"},
                   #{ip: '192.168.0.65', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "mgt-net"},
                ]
  },
}

Vagrant.configure("2") do |config|



  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
		box.ssh.insert_key = false
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end

		
                        
        case boxname.to_s
        when "inetRouter"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsR.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "inetRouter.yml"
		  end
			
			
#===================OfficeCentral
        when "centralRouter"
          box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsR.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "centralRouter.yml"
		  end

        when "centralServer"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsS.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "centralServer.yml"
		  end
			
			
#===================Office1	
			when "office1Router"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsR.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "office1Router.yml"
		  end

			when "office1Server"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsS.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "office1Server.yml"
		  end
			
			
#===================Office2			
			when "office2Router"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsR.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "office2Router.yml"
		  end
			when "office2Server"
		  box.vm.provision "ansible", run: "always", type: "ansible_local"  do |ansible|
			ansible.become = true
			ansible.galaxy_role_file = "requirementsS.yml"
			ansible.galaxy_roles_path = "/etc/ansible/collections"
			ansible.galaxy_command = "sudo ansible-galaxy collection install -r %{role_file} -p %{roles_path} --force"
			ansible.playbook = "office2Server.yml"
		  end

        end
			
      end

   end
   
end