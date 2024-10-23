#!/bin/bash

# Getting server IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Adding docker keys
sudo apt-get install ca-certificates 
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adding docker packages
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# System updating
sudo apt update && apt upgrade -y
# Docker installation
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Creating a folder for user data
mkdir -p /data/teamspeak
# Make the 503 user an owner of the folder
chown -R 503:503 /data/teamspeak

# Starting teamspeak container
docker run -d --restart=always --name teamspeak -e PUID=503 -e PGID=503 -e TS3SERVER_GDPR_SAVE=false -e TS3SERVER_LICENSE=accept -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 -v /data/teamspeak:/data mbentley/teamspeak

# Wait 15 sec
sleep 15

# Searching admin token in logs
ADMIN_TOKEN=$(grep -r "token=" /data/teamspeak/logs | awk -F'token=' '{print $2}')

# Show admin token
echo "------------------------------------------------------------------"
echo "TeamSpeak server has been installed and started."
echo "Your admin token is: $ADMIN_TOKEN"
echo "IP-address for connect to server: $IP_ADDRESS"
