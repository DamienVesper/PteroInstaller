# Prerequisites for installing Pterodactyl.
# Created by DamienVesper#0001

# Install packages.
apt install sudo nginx ufw snapd 

# Setup certbot.
# You will need to get certificates yourself!

snap install core
snap refresh all

snap install certbot --classic
snap refresh all


