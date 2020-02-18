FROM mono:slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd

RUN apk install  ca-certificates curl openssl git tar bash sqlite fontconfig && \
    apk install lib32gcc1 && \
    cert-sync /etc/ssl/certs/ca-certificates.crt && \
    adduser -D -h /home/container container && \
    cd $STEAMCMDDIR && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 
    
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
