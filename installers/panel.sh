# Pterodactyl Panel installer for Debian 10
# Created by DamienVesper#0001

sudo apt update
sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common

# Get PPA for PHP 8.0.
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -

# Update the package list.
sudo apt update

# Install all the packages.
apt -y install php8.0 php8.0-{cli,gd,mysql,pdo,mbstring,tokenizer,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server

# Install composer.
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Create the Pterodactyl panel folder.
mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl

# Download the panel source.
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz

chmod -R 755 storage/* bootstrap/cache/

# Install the panel.
cp .env.example .env
composer install --no-dev --optimize-autoloader

php artisan key:generate --force

read -p "Press [Enter] key to continue installation..."
php artisan p:environment:setup

read -p "Press [Enter] key to continue installation..."
php artisan p:environment:database

php artisan migrate --seed --force

read -p "Press [Enter] key to continue installation..."
php artisan p:user:make

chown -R www-data:www-data /var/www/pterodactyl/*

# Systemd daemon handling.
sudo systemctl enable --now redis-server
