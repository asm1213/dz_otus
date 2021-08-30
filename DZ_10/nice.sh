#!/bin/bash
rm -rf ./test*
dd if=/dev/zero of=/vagrant/testfile bs=128MB count=1 oflag=direct

function hi {
d1=$(date +%s)
nice -n -20 tar caf /vagrant/testhi.tar.xz ./vagrant/testfile
d2=$(date +%s)
echo "HI "$(expr $d2 - $d1)
}

function low {
d1=$(date +%s)
nice -n 20 tar caf /vagrant/testlow.tar.xz ./vagrant/testfile
d2=$(date +%s)
echo "LOW "$(expr $d2 - $d1)
}

low &
hi &

wait




