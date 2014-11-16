FROM ubuntu:14.04

RUN apt-get update && apt-get install -y apache2
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod ssl dav_fs
RUN rm /etc/apache2/sites-enabled/*
ADD dav_ssl.conf /etc/apache2/sites-enabled/
RUN chown -R www-data /var/www

EXPOSE 443
VOLUME /htpasswd
VOLUME /var/www
VOLUME /certs

CMD ["/usr/sbin/apache2ctl", "-D",  "FOREGROUND"]
