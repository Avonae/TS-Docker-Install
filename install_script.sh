#!/bin/bash

# Получаем IP-адрес сервера
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Добавляем текущего юзера в переменную
CURRENT_USER=$(awk -F: '$3 >= 1000 && $3 < 65534 {print $1; exit}' /etc/passwd)

# Добавляем ключи докера
sudo apt-get install ca-certificates 
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Добавляем пакеты докера:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем систему
sudo apt update && apt upgrade -y
# ставим докер
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Добавляем текущего пользователя в группу докера 
sudo usermod -aG docker $CURRENT_USER

# перезапускаем сессию 
newgrp docker

# Создаем папку для пользовательских данных
mkdir -p /data/teamspeak
# Назначаем владельцем папки бесправного пользователя
chown -R 503:503 /data/teamspeak

# Запускаем контейнер с тимсписком
docker run -d --restart=always --name teamspeak -e PUID=503 -e PGID=503 -e TS3SERVER_GDPR_SAVE=false -e TS3SERVER_LICENSE=accept -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 -v /data/teamspeak:/data mbentley/teamspeak

# Ждем 15 секунд
sleep 15

# Ищем строку с токеном в логах
ADMIN_TOKEN=$(grep -r "token=" /data/teamspeak/logs | awk -F'token=' '{print $2}')

# Выводим токен администратора
echo "------------------------------------------------------------------"
echo "Сервер TeamSpeak установлен и запущен."
echo "Ваш токен администратора: $ADMIN_TOKEN"
echo "IP-адрес сервера для подключения: $IP_ADDRESS"
