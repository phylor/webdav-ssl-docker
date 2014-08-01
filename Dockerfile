FROM ubuntu:14.04

ENV PASSWORD password
# ...put your own build instructions here...
RUN apt-get update && apt-get install -y \
  build-essential \
  apache2 \
  apache2-utils

RUN a2enmod rewrite ssl dav_fs
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD 000-default.conf /etc/apache2/sites-enabled/
ADD dav_fs.conf /etc/apache2/mods-enabled/
RUN htpasswd -bc /etc/apache2/htpasswd admin $PASSWORD
ADD ssl.conf /etc/apache2/sites-enabled/
ADD munkiwebadmin.crt /etc/ssl/certs/
ADD munkiwebadmin.key /etc/ssl/private/
RUN chown -R www-data /var/www

EXPOSE 80
EXPOSE 443
VOLUME /var/www

CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
