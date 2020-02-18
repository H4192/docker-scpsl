apt-get -y update
echo "GITHUB version"
mkdir -p ./server ./steamcmd

cd steamcmd
wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -
cd ..
/home/container/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container/server +app_update 996560 -validate +exit 

cd /home/container/server
${STARTUP}
