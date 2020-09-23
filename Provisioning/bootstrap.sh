#!/usr/bin/env bash

export UPDATE_SYSTEM=0
TIME_ZONE_FILE=/usr/share/zoneinfo/Europe/London

# ===================================================================
# Pretify logging to screen
# ===================================================================
printLog() {
  printf "[${VAGRANT_HOST}-bootstrap] $1\n";
}

installComposer() {
	printLog "Install GIT"
	sudo apt get --assume-yes install git
	if [[ -s /vagrant/composer.json ]] ;then
	  cd /vagrant || return;
	  printLog "Installing Composer for PHP package management"
	  curl --silent https://getcomposer.org/installer | php
	  php composer.phar install --quiet --prefer-dist > /dev/null
	  cd ~ || exit;
	fi
}

installMysql(){
	printLog "Installing DB";
	sudo apt install --assume-yes mysql-server
	printLog "Start mysql server";	
	sudo systemctl start mysql
	printLog "Precona password";
	#cat /var/log/mysqld.log | grep root@localhost: > ~/_last
	#awk 'NF>1{print $NF}' ~/_last > ~/precona.password
	#mysql -u root -p`cat ~/precona.password` -e "alter user 'root'@'localhost' identified by 'RootPw90$' " --connect-expired-password
	#mysql -u root  -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))"
	#rm ~/_last
	#rm ~/precona.password
}

importDB(){
	printLog "Import DB";
	sudo mysql -u root -e "create database system_core"

	sudo mysql -u root -e "create user 'system_core'@'localhost' identified by 'Nokia82!0' "
	sudo mysql -u root -e "create user 'system_core'@'%' identified by 'Nokia82!0' "

	sudo mysql -u root -e "GRANT ALL PRIVILEGES on * . * to 'system_core'@'localhost' "
	sudo mysql -u root -e "GRANT ALL PRIVILEGES on * . * to 'system_core'@'%' "

	sudo mysql --host localhost --user=root system_core < /vagrant/data/system_core.sql
}

installPHP(){

	printLog "Install PHP"
	sudo apt --assume-yes install php
	sudo apt -y install php-xml
	sudo apt -y install php-mbstring
	sudo apt -y install php-mysql

sudo echo '<VirtualHost *:80>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /vagrant/public

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	<Directory "/vagrant/public">
    	AllowOverride "All"
		Options SymLinksIfOwnerMatch
		Require all granted
		Order allow,deny
		Allow from all
  	</Directory>
</VirtualHost>
'  > /etc/apache2/sites-available/000-default.conf
}


printLog "Setting Timzone for host";
mv /etc/localtime /etc/localtime.orig
ln -s $TIME_ZONE_FILE /etc/localtime

sudo apt-get --assume-yes update
printLog "Install MC"
sudo apt --assume-yes install mc 
sudo apt --assume-yes install wget




printLog "Change permissions"


#sudo setsebool -P httpd_can_network_connect=1
sudo a2enmod rewrite
installPHP
installComposer;
installMysql;
importDB;

chmod 777 /vagrant/logs/app.log

printLog "Restart apache";
sudo service mysql restart
sudo service apache2 restart