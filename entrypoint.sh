apt-get -y update

mkdir -p /home/container/steamcmd
cd /home/container/steamcmd
wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - 
mkdir -p /home/container/server/

/home/container/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container/server +app_update 996560 -validate +exit 
