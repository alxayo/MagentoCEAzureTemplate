#!/bin/bash

#[arg 1] is the artifact archive name. example: magento2.tar.gz
#[arg 2] is the mysql root password. example: pwr00t
clear

echo "Extract Magento 2 package"
echo "----"sudo 
sudo mkdir /var/www/html/magento
sudo tar -xzvf $1 -C /var/www/html/magento

echo "Fix file permissions"
echo "----"
cd /var/www/html/magento
sudo find var vendor pub/static pub/media app/etc -type f -exec chmod u+w {} \;
sudo find var vendor pub/static pub/media app/etc -type d -exec chmod u+w {} \;
sudo chmod u+x bin/magento

echo "Run Composer install"
echo "----"
cd /var/www/html/magento
composer install

echo "Run Magento install script"
echo "----"
php /var/www/html/magento/bin/magento setup:install --base-url=http://127.0.0.1/magento/ \
--db-host=localhost --db-name=magento --db-user=root --db-password=$2 \
--admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
--admin-user=admin --admin-password=@dm1n12qw12qw --language=en_US \
--currency=USD --timezone=America/Chicago --use-rewrites=1