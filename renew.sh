#!/bin/sh
/usr/bin/certbot renew --webroot-path -w /var/www/letsencrypt --quiet --no-self-upgrade
