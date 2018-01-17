#!/bin/sh
/bin/certbot-auto renew --webroot-path /var/www/letsencrypt --quiet --no-self-upgrade
