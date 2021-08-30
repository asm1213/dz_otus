#!/bin/bash

yum install -y update

# part1

cat >> /opt/srservice.sh << EOF
#!/bin/bash
WORD=\$1
LOG=\$2
DATE=\`date\`
if grep \$WORD \$LOG &> /dev/null
then
echo "Ok"
logger \$DATE : !Holy Penguin!
else
exit 0
fi
EOF

sudo chmod +x /opt/srservice.sh

cat >> /etc/sysconfig/srservice.cfg << EOF
WORD="OPTIONS"
LOG=/var/tmp/vi.man
EOF

cat >> /etc/systemd/system/sr.service << EOF
[Unit]
Description=My test service
[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/srservice.cfg
ExecStart=/opt/srservice.sh \$WORD \$LOG
EOF

cat >> /etc/systemd/system/srtimer.timer << EOF
[Unit]
Description=Run srservice every 15 second
[Timer]
OnUnitActiveSec=15
Unit=sr.service
[Install]
WantedBy=multi-user.target
EOF

man vi >> /var/tmp/vi.man

systemctl daemon-reload
systemctl start srtimer.timer
systemctl enable srtimer.timer
systemctl start sr.service
systemctl enable sr.service


#part2

yum install -y epel-release 
yum install -y spawn-fcgi php php-climod_fcgid

rm -f /etc/sysconfig/spawn-fcgi
cat >> /etc/sysconfig/spawn-fcgi <<EOF
SOCKET=/var/run/php-fcgi.sock
OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"
EOF
#-P /var/run/spawn-fcgi.pid 
cat >> /etc/systemd/system/spawn-fcgi.service << EOF
[Unit]
Description=Spawn-fcgi startup service
After=network.target
[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n \$OPTIONS
KillMode=process
[Install]
WantedBy=multi-user.target
EOF

systemctl start spawn-fcgi

#part3
yum install -y httpd
mv  /usr/lib/systemd/system/httpd.service /usr/lib/systemd/system/httpd@.service
sed -i '9 s/httpd/httpd-%I/1' /usr/lib/systemd/system/httpd@.service

mv /etc/sysconfig/httpd /etc/sysconfig/httpd-first
cp /etc/sysconfig/httpd-first /etc/sysconfig/httpd-second

sed -i '17 s/#OPTIONS=/OPTIONS=-f conf\/first.conf/1'  /etc/sysconfig/httpd-first
sed -i '17 s/#OPTIONS=/OPTIONS=-f conf\/second.conf/1'  /etc/sysconfig/httpd-second

mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
cp /etc/httpd/conf/first.conf /etc/httpd/conf/second.conf

sed -i  '42 s/80/8080/1' /etc/httpd/conf/second.conf
sed -i '43iPidFile  \/var\/run\/httpd-second.pid' /etc/httpd/conf/second.conf


systemctl start httpd@first
systemctl start httpd@second