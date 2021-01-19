FROM debian:buster

# Upgrading package manager
RUN apt-get update

# Installing packages
# nginx: our server
RUN apt-get install -y nginx

# mariadb: mysql database
RUN apt-get install -y mariadb-server

# php-fpm: "PHP fastCGI process manager"
# php-mysql: allows to write mysql queries in php script
RUN apt-get install -y php-fpm php-mysql

# wget - widget to open url and download file on url
RUN apt-get install -y wget

# moving srcs files to root directory in docker os (debian:buster)
COPY ./srcs/init.sh ./
COPY ./srcs/nginx.conf ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/config.inc.php ./

# change current working directory
WORKDIR /var/www/
# download latest version of wordpress
RUN wget https://wordpress.org/latest.tar.gz
# unarchive wordpress archive
RUN tar -xzvf latest.tar.gz

WORKDIR /var/www/wordpress
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.4-english.tar.gz && mv phpMyAdmin-5.0.4-english/ phpmyadmin

CMD bash /init.sh