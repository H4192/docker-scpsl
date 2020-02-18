FROM debian:buster-slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd


RUN apt-get -y install  ca-certificates curl openssl git tar bash sqlite fontconfig && \
    apt-get install lib32gcc1 && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    adduser -D -h /home/container container && \
    cd $STEAMCMDDIR && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 


RUN mkdir -p /home/container
RUN useradd -d /home/container container
RUN chown -R container:container /home/container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
