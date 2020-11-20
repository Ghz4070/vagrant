#!/bin/sh

set -ue

apt-get update
apt-get install -y git git-flow

mkdir -p /home/vagrant/.ssh
cp /vagrant/vagrant@server_rsa /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/vagrant@server_rsa

rm -f /home/vagrant/.ssh/config
echo "Host server" > /home/vagrant/.ssh/config
echo "  Hostname 192.168.50.10" >> /home/vagrant/.ssh/config
echo "  User vagrant" >> /home/vagrant/.ssh/config
echo "  IdentityFile ~/.ssh/vagrant@server_rsa" >> /home/vagrant/.ssh/config
chmod 0600 /home/vagrant/.ssh/config
chown -R vagrant:vagrant /home/vagrant/.ssh

su vagrant -c 'git config --global user.name "Glenn Y. Rolland"'
su vagrant -c 'git config --global user.email "glenux@glenux.net"'

mkdir -p /home/vagrant/project
git init /home/vagrant/project
cd /home/vagrant/project
git remote add origin vagrant@server:fitec/project.git
chown -R vagrant:vagrant /home/vagrant/project

echo "SUCCESS"

