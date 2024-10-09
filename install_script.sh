#!/bin/bash

# Создаем папку для пользовательских данных
mkdir -p /data/teamspeak
# Назначаем владельцем папки бесправного пользователя
chown -R 503:503 /data/teamspeak
# Открываем нужные порты в системе
sudo ufw allow 9987/udp 30033/tcp 10011/tcp 41144/tcp

# Запускаем контейнер с тимсписком
docker run -d --restart=always --name teamspeak \
  -e PUID=503 \
  -e PGID=503 \
  -e TS3SERVER_GDPR_SAVE=false \
  -e TS3SERVER_LICENSE=accept \
  -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 \
  -v /data/teamspeak:/data \
  mbentley/teamspeak
  
# Ждем запуска контейнера и получаем токен администратора
echo "Ожидание запуска TeamSpeak сервера..."
sleep 10
ADMIN_TOKEN=$(sudo docker logs teamspeak 2>&1 | grep 'token=' | awk -F 'token=' '{print $2}')

# Выводим токен от сервера
echo "TeamSpeak установлен и запущен."
echo "Ваш токен администратора: $ADMIN_TOKEN"