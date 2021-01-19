service mysql start  # ?


# /var/www/html - used for default site if client request doesn't match other sites
# creating folder for my site



# mv /index.php /var/www/wordpress/index.php
# moving nginx.conf to site file
mv -f /nginx.conf /etc/nginx/sites-available/default
mv /wp-config.php /var/www/wordpress
mv /config.inc.php /var/www/wordpress/phpmyadmin/
# chown -R www-data:www-data /var/www/wordpress/phpmyadmin # ?

# Create SSL self-signed sertificate
# -subj '/CN=localhost'   — suppress questions about contents of sertificate
# -nodes                  - no need for passphrase
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=localhost' -nodes

# Setup MYSQL
mysql -u root --skip-password -e "CREATE DATABASE wordpress;"
# GRANT ALL PRIVILGES could be set to specific SELECT, UPDATE...
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';"
mysql -u root --skip-password -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"


service php7.3-fpm start # php7.3 is the version used in debian buster
service nginx start
bash