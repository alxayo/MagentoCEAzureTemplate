#!/bin/bash

clear

echo "removing software requirements for Magento 2.x"

echo "remove MySQL 5.6"
echo "----"
sudo mysqld stop
sudo apt-get -y -q remove mysql-client-5.6
sudo apt-get -y -q remove mysql-server-5.6 
sudo apt-get -y -q autoremove
sudo apt-get -y -q autoclean

echo "remove Composer"
sudo find / -iname composer.phar -exec rm {} \+;

echo "Stop Apache"
service apache2 stop

echo "remove PHP 5.6"
sudo apt-get -y -q remove php5.6 php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip
sudo apt-get -y -q autoremove
sudo apt-get -y -q autoclean

echo "remove Apache 2.4.x"
echo "----"
sudo apt-get -y -q remove apache2
sudo apt-get -y -q autoremove
sudo apt-get -y -q autoclean