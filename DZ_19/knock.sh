#!/bin/bash
#chmod +x /vagrant/knock.sh && ./knock.sh 192.25.10.10 8881 7777 9991
HOST=$1
shift
for ARG in "$@"
do
        sudo nmap -Pn --max-retries 0 -p $ARG $HOST
done