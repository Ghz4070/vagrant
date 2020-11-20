
# TP n°5 : Mise en place d'un serveur GIT (un dépot git distant)

## 1. Vagrant

### 1. Ecrire une configuration Vagrant (Vagrantfile) ...

Créer le Vagrantfile

   vagrant init

On modifie la box à 'debian/buster64' et on ajoute également les lignes
suivantes dans le fichier :

    config.vm.define 'server' do |machine|
      machine.vm.hostname = 'server'
      machine.vm.provision 'shell', path: 'provision.server.sh'
      machine.vm.network 'private_network', ip: '192.168.50.10'
      machine.vm.network 'forwarded_port', guest: 80, host: 7891 #, host_ip: "127.0.0.1"
    end
  
    config.vm.define 'client' do |machine|
      machine.vm.hostname = 'client'
      machine.vm.provision 'shell', path: 'provision.client.sh'
      machine.vm.network 'private_network', ip: '192.168.50.20'
    end

On crée les scripts

    touch provision.client.sh
    touch provision.server.sh

Le contenu du provisioning client :

    #!/bin/sh

    set -ue

    apt-get update
    apt-get install -y git git-flow

    echo "SUCCESS"

Le contenu du provisioning serveur :

    #!/bin/sh

    set -ue

    apt-get update
    apt-get install -y git

    echo "SUCCESS"



## 2. SSH

### 2.1. Generer une paire de clefs SSH 

On lance la génération de cléf sur la machine host

    ssh-keygen -f vagrant@serveur_rsa

Au final, on se retrouve avec les fichiers suivants :

    provision.client.sh
    provision.server.sh
    Vagrantfile
    vagrant@serveur_rsa       <-- ajouté par le ssh-keygen
    vagrant@serveur_rsa.pub   <-- ajouté par le ssh-keygen

### 2.2. et 2.3. On veut également que les clefs SSH soient copiées au bon endroit (...)

Rappel : le dossier du projet sera accessible à travers le dossier /vagrant
dans la VM pendant le provisioning et pendantle fonctionnement de la VM.

Dans le fichier provision.client.sh, on ajoute :

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

Dans le fichier provision.server.sh, on ajoute :

    mkdir -p /home/vagrant/.ssh
    cat /vagrant/vagrant@server_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chmod 0700 /home/vagrant/.ssh
    chmod 0600 /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh


## 3. GIT

### 3.1 Configurer GIT globalement sur 'client' et 'serveur'

Sur provisioning client :

    git config --global user.name "Glenn Y. Rolland"
    git config --global user.email "glenux@glenux.net

Sur provisioning server :

    git config --global user.name "Admin Vagrant"
    git config --global user.email "nobody@example.com"

### 3.2 et 3.3. Création des dépots

Sur le provisioning serveur : 

    mkdir -p /home/vagrant/fitec/project.git
    git init --bare /home/vagrant/fitec/project.git
    chown -R vagrant:vagrant /home/vagrant/fitec

Sur le provisioning client :

    mkdir -p /home/vagrant/project
    git init /home/vagrant/project
    cd /home/vagrant/project
    git remote add origin vagrant@server:fitec/project.git
    chown -R vagrant:vagrant /home/vagrant/project

5. On fait des commits
6. Pousser l'historique vers le serveur


