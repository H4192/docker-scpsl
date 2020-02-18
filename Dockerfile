FROM debian:buster-slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd

RUN dpkg --add-architecture i386
    
RUN apt-get -y update
    
RUN apt-get -y install mailutils postfix curl wget file tar bzip2 && \
    apt-get -y install gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux  && \
    apt-get -y install lib32gcc1 libstdc++6 libstdc++6:i386 libtinfo5:i386

RUN apt-get -y install git tar bash sqlite fontconfig

RUN apt-get -y install ca-certificates

RUN mkdir -p $STEAMCMDDIR
    
RUN useradd -d /home/container container && \
    cd $STEAMCMDDIR && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 


RUN mkdir -p /home/container
RUN useradd -d /home/container container
RUN chown -R container:container /home/container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
