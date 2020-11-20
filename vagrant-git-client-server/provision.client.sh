#!/bin/sh

set -e
set -u

apt-get update
apt-get install -y git git-flow

# le -p si le dossier existe deja il ne plante pas
mkdir -p /home/vagrant/.ssh
cp /vagrant/.ssh/client/vagrant@server_rsa /home/vagrant/.ssh
cp /vagrant/.ssh/config /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh

echo 'Success : client'
