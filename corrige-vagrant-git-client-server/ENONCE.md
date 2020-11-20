
# TP n°5 : Mise en place d'un serveur GIT (un dépot git distant)

## 1. Vagrant

1. Ecrire une configuration Vagrant (Vagrantfile) permettant de lancer deux
   machines
   * une machine **client**
   * une machine **serveur**
   * les deux doivent pouvoir communiquer ensemble (se ping-er l'une l'autre)
2. Chaque machine doit posséder son propre script de provisioning
3. On veut installer sur chaque machine les paquets suivants :
   * **client** : git git-flow
   * **serveur** : git

## 2. SSH

1. Generer une paire de clefs SSH `vagrant@server_rsa` et
   `vagrant@server_rsa.pub` sur votre systeme hote
2. On veut également que les clefs SSH soient copiées au bon endroit, dans la bonne machine
   * client: `vagrant@server_rsa` dans `/home/vagrant/.ssh`
   * serveur: `vagrant@server_rsa.pub` dans `/home/vagrant/.ssh/authorized_keys`
   * cette copie sera faite dans les scripts de provisioning
3. Mettre les bons droits aux bons fichiers
   * 0700 => `~/.ssh`
   * 0600 => `~/.ssh/authorized_keys`
   * 0600 => `~/.ssh/known_hosts`
   * 0600 => `~/.ssh/config`
   * 0600 => `~/.ssh/vagrant@server_rsa.pub`
   * 0600 => `~/.ssh/vagrant@server_rsa`
4. Faire en sorte que ces fichiers appartiennent à vagrant:vagrant
5. Sur **client**, écrire un fichier `.ssh/config` qui automatise le processus de
   connexion avec la bonne clef et le bon user pour la machine **serveur**
6. Ouvrir une session sur la machine 'client' et essayer de se connecter sur la
   machine **serveur** en utilisant la clé privée générée au dessus

### Indices

1. Les clefs SSH sont présentes dans /vagrant depuis les VM une fois lancées
2. On peut changer les droits d'un fichier avec la commande 'chmod XXXX FILE'
   où XXXX est la permission qu'on veut donner pour le fichier FILE.
3. On peut changer l'appartenance d'un fichier avec la commande 'chown
   OWNER:GROUP FILE' où OWNER est un username, GROUP est le nom d'un groupe et
   FILE est un fichier.



## 3. GIT

1. Configurer GIT globalement sur 'client' et 'serveur'
2. On veut créer un dépot GIT bare dans /home/vagrant/fitec/project.git
3. Créer un dossier 'project' coté client, et initialiser un dépot GIT dedans
4. On configure le dépot GIT client pour se connecter au dépot GIT serveur
5. On fait des commits
6. Pousser l'historique vers le serveur

