apt -y uodate

mkdir -p /home/container/server/

/home/container/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container/server +app_update 996560 -validate +exit 
