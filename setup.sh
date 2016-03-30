#!/usr/bin/env bash
echo "Provisioning..."

apt-get update

export DEBIAN_FRONTEND=noninteractive

echo "Installing Nginx"
apt-get install nginx -y

echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y
add-apt-repository ppa:ondrej/php5 -y
apt-get update

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm php-pear -y

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y

echo "Installing Xdebug"
pecl install xdebug -y
cp/config/php5/php.ini /etc/php5/fpm/php.ini
service php5-fpm restart

echo "Preparing MySQL"
apt-get install debconf-utils -y
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "Installing MySQL"
apt-get install mysql-server -y

echo "Setting up MySQL"
cp /vagrant/config/mysql/my.cnf /home/vagrant/.my.cnf
chmod 0600 /home/vagrant/.my.cnf
chown vagrant:vagrant /home/vagrant/.my.cnf

echo "Configuring Nginx for Wordpress"
mkdir /etc/nginx/global/
cp /vagrant/config/nginx/global/php.conf /etc/nginx/global/
cp /vagrant/config/nginx/global/restrictions.conf /etc/nginx/global/
cp /vagrant/config/nginx/global/wordpress.conf /etc/nginx/global/

echo "Setting up Sudoeste Imóveis"
cp /vagrant/config/nginx/sudoesteimoveis.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/sudoesteimoveis.conf /etc/nginx/sites-enabled
​
echo "Configuring Nginx for coach.dev"
cp /vagrant/config/coach.nginx.conf /etc/nginx/sites-available/coach
ln -s /etc/nginx/sites-available/coach /etc/nginx/sites-enabled/

rm -rf /etc/nginx/sites-available/default

service nginx restart

echo "Done Provisioning"
