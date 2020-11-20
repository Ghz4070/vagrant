#!/bin/sh

set -e
set -u

apt-get update
apt-get install -y git

mkdir /home/vagrant/.ssh
mkdir /home/vagrant/.ssh/authorized_keys
cp ./.ssh/server/vagrant@server_rsa.pub /home/vagrant/.ssh/authorized_keys

chown vagrant:vagrant /home/vagrant/.ssh
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys/vagrant@server_rsa.pub

chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys/vagrant@server_rsa.pub

echo 'Success : server'
