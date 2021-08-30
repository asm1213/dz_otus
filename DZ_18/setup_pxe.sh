#!/bin/bash

yum -y install epel-release

yum -y install dhcp-server
yum -y install tftp-server
firewall-cmd --add-service=tftp
yum -y install nginx

sed -i '42s/\/usr\/share\/nginx\/html/\/var\/lib\/tftpboot\/pxelinux/g' /etc/nginx/nginx.conf
sed -i '47s/{/{ autoindex on;/g' /etc/nginx/nginx.conf

setenforce 0

cp /vagrant/dhcpd.conf /etc/dhcp

systemctl start dhcpd
systemctl enable dhcpd

systemctl start tftp.service
systemctl enable tftp.service

yum -y install syslinux-tftpboot.noarch

mkdir /var/lib/tftpboot/pxelinux
cp /tftpboot/lpxelinux.0 /var/lib/tftpboot/pxelinux
cp /tftpboot/libutil.c32 /var/lib/tftpboot/pxelinux
cp /tftpboot/menu.c32 /var/lib/tftpboot/pxelinux
cp /tftpboot/libmenu.c32 /var/lib/tftpboot/pxelinux
cp /tftpboot/ldlinux.c32 /var/lib/tftpboot/pxelinux
cp /tftpboot/vesamenu.c32 /var/lib/tftpboot/pxelinux

mkdir /var/lib/tftpboot/pxelinux/pxelinux.cfg

cp /vagrant/default /var/lib/tftpboot/pxelinux/pxelinux.cfg

mkdir -p /var/lib/tftpboot/pxelinux/images/CentOS-8/
curl -O http://ftp.mgts.by/pub/CentOS/8.3.2011/BaseOS/x86_64/os/images/pxeboot/initrd.img
curl -O http://ftp.mgts.by/pub/CentOS/8.3.2011/BaseOS/x86_64/os/images/pxeboot/vmlinuz
cp {vmlinuz,initrd.img} /var/lib/tftpboot/pxelinux/images/CentOS-8/

autoinstall(){
  curl -O http://ftp.mgts.by/pub/CentOS/8.3.2011/isos/x86_64/CentOS-8.3.2011-x86_64-boot.iso
  mkdir /var/lib/tftpboot/pxelinux/images/CentOS-8/CentOS8.3.2011
  mount -t iso9660 CentOS-8.3.2011-x86_64-boot.iso /var/lib/tftpboot/pxelinux/images/CentOS-8/CentOS8.3.2011
  mkdir /home/vagrant/cfg
  cp /vagrant/ks.cfg /var/lib/tftpboot/pxelinux
}

systemctl start nginx.service
systemctl enable nginx.service

autoinstall
