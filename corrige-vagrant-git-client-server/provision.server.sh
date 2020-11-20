#!/bin/sh

set -ue

apt-get update
apt-get install -y git

mkdir -p /home/vagrant/.ssh
cat /vagrant/vagrant@server_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

su vagrant -c 'git config --global user.name "Admin Vagrant"'
su vagrant -c 'git config --global user.email "nobody@example.com"'

mkdir -p /home/vagrant/fitec/project.git
git init --bare /home/vagrant/fitec/project.git
chown -R vagrant:vagrant /home/vagrant/fitec

echo "SUCCESS"
