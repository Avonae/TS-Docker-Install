#!/bin/bash

# Обновление списка пакетов
sudo apt update && sudo apt upgrade -y

# Установка Docker
sudo apt install -y docker.io

# Запуск Docker
sudo systemctl enable docker
sudo systemctl start docker

# Создание нужных папок 
mkdir -p /opt/teamspeak/data
cd /opt/teamspeak/
# Скачивание и запуск TeamSpeak контейнера
sudo docker run -d --restart-always --name teamspeak2 -e TS3SERVER_LICENSE=accept -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -p 41144:41144 -v /teamspeak/data:/data teamspeak

# Ожидание запуска контейнера и получение токена администратора
echo "Ожидание запуска TeamSpeak сервера..."
sleep 10
ADMIN_TOKEN=$(sudo docker logs teamspeak 2>&1 | grep 'token=' | awk -F 'token=' '{print $2}')

# Вывод токена администратора
echo "TeamSpeak установлен и запущен."
echo "Ваш токен администратора: $ADMIN_TOKEN"
