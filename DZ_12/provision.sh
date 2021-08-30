#!/bin/bash
yum install -y docker
#создадим пользователя testuser и группу admins 
groupadd admins
useradd -M -G admins,dockerroot testuser
#запрет логина всем кроме группы admins в выходные дни
echo login ';' '*' ';' '!'admins ';' '!'Wd0000-2400 >> /etc/security/time.conf
sed -i '6iaccount required pam_time.so' /etc/pam.d/login

#пользователь testuser получит право сделать от рута sudo /sbin/service docker restart
echo '%'testuser ALL=/sbin/service docker > /etc/sudoers.d/testuser