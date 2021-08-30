#!/bin/bash
yum update -y
yum install nfs-utils -y
mkdir /var/share
echo "10.1.1.10:/var/share /var/share nfs proto=udp,timeo=5,retrans=3,rsize=8192,wsize=8192 0 0" >> /etc/fstab
mount -a