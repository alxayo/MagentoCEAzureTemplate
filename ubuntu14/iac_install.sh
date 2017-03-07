#!/bin/bash

clear

echo "Installing software requirements for Magento 2.x"
echo "----"

echo "Update and Upgate Apt"
echo "----"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Install Apache 2.4.x"
echo "----"
sudo apt-get -y install apache2
apache2 -v

echo "enable Apache rewrite module"
echo "----"
sudo a2enmod rewrite
service apache2 restart

echo "Install PHP 5.6"
echo "----"
sudo apt-get -y update
sudo apt-get install -y language-pack-en-base
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
sudo apt-get -y update
sudo apt-get -y install php5.6 php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip

echo "Check PHP version. Should be: 5.6"
php -v

echo "Install Composer"
echo "----"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "Installing MySQL 5.6"
echo "----"
sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password $1"
sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password $1"
sudo apt-get -y -q install mysql-server-5.6 mysql-client-5.6

echo "Create Magento Database"
echo "----"
mysql -uroot -p$1 <<MYSQL_SCRIPT
create database magento;
GRANT ALL ON magento.* TO magento@localhost IDENTIFIED BY 'magento';
MYSQL_SCRIPT

