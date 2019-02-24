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
	  sudo COMPOSER=/vagrant/composer.json php composer.phar install --quiet --prefer-dist > /dev/null
	  cd ~ || exit;
	fi
}

installMysql(){
	printLog "Installing DB";
	sudo apt install --assume-yes mysql-server
	printLog "Start mysql server";	
	sudo systemctl start mysql
	printLog "Precona password";
	cat /var/log/mysqld.log | grep root@localhost: > ~/_last
	awk 'NF>1{print $NF}' ~/_last > ~/precona.password
	mysql -u root -p`cat ~/precona.password` -e "alter user 'root'@'localhost' identified by 'RootPw90$' " --connect-expired-password
	mysql -u root -p'RootPw90$' -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))"
	rm ~/_last
	rm ~/precona.password
}

importDB(){
	printLog "Import DB";
	mysql -u root -p'RootPw90$' -e "create database system_core"

	mysql -u root -p'RootPw90$' -e "create user 'system_core'@'localhost' identified by 'Nokia82!0' "
	mysql -u root -p'RootPw90$' -e "create user 'system_core'@'%' identified by 'Nokia82!0' "

	mysql -u root -p'RootPw90$' -e "GRANT ALL PRIVILEGES on * . * to 'system_core'@'localhost' "
	mysql -u root -p'RootPw90$' -e "GRANT ALL PRIVILEGES on * . * to 'system_core'@'%' "

	#mysql --host localhost --user=root --password='RootPw90$' system_core < system_core.sql
}

installPHP(){

	printLog "Install PHP"
	sudo apt --assume-yes install php
}


printLog "Setting Timzone for host";
mv /etc/localtime /etc/localtime.orig
ln -s $TIME_ZONE_FILE /etc/localtime



printLog "Install MC"
sudo apt get --assume-yes install mc 
sudo apt get --assume-yes install wget




printLog "Change permissions"


#sudo setsebool -P httpd_can_network_connect=1
installPHP
installComposer;
installMysql;
importDB;

printLog "Restart apache";
sudo /etc/init.d/mysql restart
sudo service apache2 restart