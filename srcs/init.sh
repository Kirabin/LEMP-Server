service mysql start


# /var/www/html - used for default site if client request doesn't match other sites
# creating folder for my site
mkdir /var/www/ft_domain

mv /info.php /var/www/ft_domain/info.php
# moving nginx.conf to site file
mv /nginx.conf /etc/nginx/sites-available/ft_domain
# activating configuration file by making a link
ln -s /etc/nginx/sites-available/ft_domain /etc/nginx/sites-enabled/ # ft_domain at the end?

# Setup MYSQL
service php-fpm start
service nginx start
bash