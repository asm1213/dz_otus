#!/bin/bash
yum update -y
yum install nfs-utils -y
mkdir /var/share
chmod -R 777 /var/share
echo "/var/share 10.1.1.11(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
systemctl start rpcbind
systemctl enable rpcbind
systemctl start nfs-server
systemctl enable nfs-server
exportfs -a
systemctl restart nfs-server
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=nfs3
firewall-cmd --permanent --add-service=mountd
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --reload