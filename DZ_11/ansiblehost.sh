#!/bin/bash
yum install -y epel-release
yum update -y
yum install -y ansible
cp /vagrant/ansible.cfg /etc/ansible/ansible.cfg
ansible-playbook /vagrant/playbook/epel.yml