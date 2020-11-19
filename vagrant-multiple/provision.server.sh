#!/bin/sh

# je demande l'arret en cas d'erreurs
# (variable non-définies, ou commandes avec code de retour d'erreur)
set -e
set -u

apt-get update
apt-get install -y apache2

echo 'Success : server'
