FROM ubuntu:16.04

MAINTAINER "BlueDynamics Alliance" http://bluedynamics.com
LABEL name="letsencrypt renew" \
      description="Letsencrypt, running twice a day a renew of the certs."

RUN apt-get update \
    && apt-get -y upgrade  \
    && apt-get -y dist-upgrade

RUN apt-get -y install \
        software-properties-common \
        python3-pip \
    && add-apt-repository -y ppa:certbot/certbot \
    && apt-get update \
    && apt-get -y install certbot

RUN pip3 install -U pip chaperone \
  && useradd --system -U -u 500 runapps \
  && mkdir /etc/chaperone.d

COPY renew.sh /
COPY chaperone.yaml /etc/chaperone.d/chaperone.yaml


RUN chown -R runapps /etc/letsencrypt \
    && mkdir -p /var/www/letsencrypt \
    && chown -R runapps /var/www/letsencrypt \
    && mkdir -p /var/log/letsencrypt \
    && chown -R runapps /var/log/letsencrypt \
    && mkdir -p /var/lib/letsencrypt \
    && chown -R runapps /var/lib/letsencrypt

USER runapps

VOLUME /etc/letsencrypt
VOLUME /var/www/letsencrypt

ENTRYPOINT ["/usr/local/bin/chaperone"]

