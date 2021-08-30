#!/bin/bash
yum update -y
yum install -y redhat-lsb-core
yum install -y wget
yum install -y rpmdevtools
yum install -y rpm-build
yum install -y createrepo
yum install -y yum-utils
yum install -y gcc
yum install -y gcc-c++
yum install -y epel-release
yum install -y nginx
systemctl start nginx
systemctl enable nginx
wget https://www.nano-editor.org/dist/v4/nano-4.9.3.tar.gz
rpmbuild -ts nano-4.9.3.tar.gz
rpm -i /root/rpmbuild/SRPMS/nano-4.9.3-1.src.rpm
echo "y" | yum-builddep /root/rpmbuild/SPECS/nano.spec
rpmbuild -bb /root/rpmbuild/SPECS/nano.spec
mkdir /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nano-4.9.3-1.x86_64.rpm /usr/share/nginx/html/repo/
createrepo /usr/share/nginx/html/repo/
cat >> /etc/yum.repos.d/otus.repo << EOF
[asm1]
name=sergREPO
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum --disablerepo="*" --enablerepo=asm1 install -y nano