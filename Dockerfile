FROM ubuntu:16.04

MAINTAINER "BlueDynamics Alliance" http://bluedynamics.com
LABEL name="letsencrypt renew" \
      description="Letsencrypt, running twice a day a renew of the certs." \

RUN apt-get update \
    && apt-get -y upgrade  \
    && apt-get -y dist-upgrade

RUN apt-get -y install \
        software-properties-common \
        python3-pip \
    && add-apt-repository -y ppa:certbot/certbot

RUN apt-get update
RUN apt-get -y install certbot

RUN pip3 install -U pip chaperone \
  && useradd --system -U -u 500 runapps \
  && mkdir /etc/chaperone.d

COPY renew.sh /
COPY chaperone.yaml /etc/chaperone.d/chaperone.yaml
VOLUME /etc/letsencrypt

ENTRYPOINT ["/usr/local/bin/chaperone"]
