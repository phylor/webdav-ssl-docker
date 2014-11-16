# WebDAV in Docker
Provides WebDAV access via SSL. You need to prepare your own password
file and provide your own certificate/key.

This repository has been originally forked from https://github.com/groob/docker-webdav.

## Create Password File

    htpasswd -c htpasswd username

## Certificates
You require a server certificate and a corresponding key for the SSL
connection. They need to be in a directory and called `web.crt` and
`web.key`.

## Exposed Volumes

- `/certs`: Containing server certificate and key for SSL
- `/htpasswd`: Htpasswd file for DAV authentication
- `/var/www`: DAV content

## Run Container

    docker run --name webdav-ssl -v /path/to/htpasswd:/htpasswd -v /path/to/certs:/certs -p 10000:443 phylor/webdav-ssl
