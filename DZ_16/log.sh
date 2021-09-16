#!/bin/bash
yum -y update
yum -y install systemd-journal-gateway
mkdir -p /var/log/journal/remote
chown systemd-journal-remote:systemd-journal-remote /var/log/journal/remote
systemctl start 