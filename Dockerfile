FROM ubuntu:14.04

ENV DAV_USER admin
ENV DAV_PASS password

RUN apt-get update && apt-get install -y \
  apache2 \
  apache2-utils
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod ssl dav_fs
RUN rm /etc/apache2/sites-enabled/*
RUN htpasswd -bc /etc/apache2/htpasswd $DAV_USER $DAV_PASS
ADD dav_ssl.conf /etc/apache2/sites-enabled/
ADD web.crt /etc/ssl/certs/
ADD web.key /etc/ssl/private/
RUN chown -R www-data /var/www

EXPOSE 443
VOLUME /var/www

CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]
