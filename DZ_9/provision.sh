#!/bin/bash
yum install -y update
yum install -y mailx
yum install -y flock
chmod +x /vagrant/pars.sh

#Начальная дата для певого фильтра лога, для демонстрации работы 
cat >> /var/tmp/parstime.log << EOF
1990-01-01T00:00:00
EOF

#Задания с блокировкой повторного запуска через flock
crontab -l | { cat; echo "0 */1 * * * /usr/bin/flock -xn /var/lock/pars.lock -c 'sh /vagrant/pars.sh'"; } | crontab - 