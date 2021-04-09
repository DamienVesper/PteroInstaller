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

# Setup UFW.
ufw default deny

ufw limit 22

ufw allow 80
ufw allow 443

ufw allow 8080
ufw allow 2022

ufw enable

