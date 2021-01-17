service mysql start


# /var/www/html - used for default site if client request doesn't match other sites
# creating folder for my site



mv /index.php /var/www/wordpress/index.php
# moving nginx.conf to site file
mv -f /nginx.conf /etc/nginx/sites-available/default

# Setup MYSQL
mysql -u root --skip-password -e "CREATE DATABASE wordpress"
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';"
mysql -u root --skip-password -e "FLUSH PRIVILIGES;"

service php7.3-fpm start # php7.3 is the version used in debian buster
service nginx start
bash