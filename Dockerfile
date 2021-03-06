FROM debian:buster-slim

MAINTAINER Worreh, worreh@gmail.com

ENV STEAMCMDDIR /home/container/steamcmd

RUN dpkg --add-architecture i386
    
RUN apt-get -y update && \
    apt-get -y install mailutils postfix curl wget file tar bzip2 && \
    apt-get -y install gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux  && \
    apt-get -y install lib32gcc1 libstdc++6 libstdc++6:i386 libtinfo5:i386 && \
    apt-get -y install apt-transport-https dirmngr gnupg && \
    apt-get -y install git tar bash sqlite fontconfig
    
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF 

RUN echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get -y install mono-devel

RUN apt-get -y install ca-certificates ca-certificates-mono


RUN useradd -d /home/container container
RUN mkdir /home/container
RUN chown -R container:container /home/container


USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN mkdir -p ./steamcmd

RUN cd ./steamcmd && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 

RUN chown -R container:container /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
