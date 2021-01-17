FROM debian:buster

# Upgrading package manager
RUN apt-get update

# Installing packages
# nginx: our server
RUN apt-get install -y nginx

# mariadb: mysql database
RUN apt-get install -y mariadb-server

# php-fpm: "PHP fastCGI process manager" - bridge between server and php scripts ? 
# php-mysql: allows to write mysql queries in php script
RUN apt-get install -y php-fpm php-mysql

# wget - widget to open url and download file on url
RUN apt-get install -y wget




COPY ./srcs/init.sh ./
COPY ./srcs/mysql_setup.sql ./
# moving to root because site folder isn't created yet
COPY ./srcs/nginx.conf ./
COPY ./srcs/index.php ./

# change current working directory
WORKDIR /var/www/
# download latest version of wordpress
RUN wget https://wordpress.org/latest.tar.gz
# unarchive wordpress archive
RUN tar -xzvf latest.tar.gz

WORKDIR /var/www/wordpress
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.4-english.tar.gz
RUN mv phpMyAdmin-5.0.4-english/ phpmyadmin


CMD bash /init.sh

# COPY nginx.conf /etc/nginx/nginx.conf
# NOTES
# - You sould use apt-get update and apt-get install in one RUN instruction




# Notes
	# Layers do get reused.
	# apt-get -y flag is for "auto-yes"