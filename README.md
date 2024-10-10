# Свой сервер тимспика за 10 минут или замена дискорду без ВПН
Мне не нравится дискорд, так его еще и заблокировали. Эта инструкция поможет сделать свой сервер тим спика и болтать с друзьями в чудесном качестве. 
Для сравнения: тим спик позволяет использовать звук 100 Кб/с, а дискорд бесплатным пользователям дает только 64 Кб/с.

Для установки вам понадобится арендовать выделенный сервер — VPS. Обычно он стоит от 100р/месяц. Наберите в поиске "недорогие VPS" и вы все найдете. Лучше почитайте отзывы и выбирайте большие компании, а не слишком мелкие. Для наших целей ресурсов самого дешевого тарифа вполне вполне хватит.
Сервер вы можете использовать не только для тимспика, а на крутить много всего. Если купить сервер за рубежом, можно его использовать как VPN.

Тим спик будет работать как [контейнер в докере](https://ru.wikipedia.org/wiki/Docker), что позволит не замусоривать систему и удобно им управлять.

После оплаты вы получите следующие данные:
- IP-адрес сервера для [подключения по SSH](https://firstvds.ru/technology/how-to-connect-to-the-server-via-ssh)
- логин и пароль от root или пользователя с правами sudo. Инструкция рассчитана на этот вариант

# Установка сервера
Установщик всё сделает сам в 1 команду. Код скрипта находится тут же, [можете ознакомиться](https://github.com/Avonae/TS-Docker-Install/blob/main/install_script.sh).

Процесс установки довольно прост:
1. Подключитесь к серверу по SSH. Для этого открываете терминал и пишете: `ssh имя_пользователя@IP_адрес_вашего_сервера`. Например, у меня пользователя зовут `alex`, поэтому я пишу `ssh alex@192.168.31.180`. У вас это может быть `root` или другой пользователь.
2. Напишите `yes` для принятия сертификата
![image](https://github.com/user-attachments/assets/b6d021d1-69c0-4710-8a4c-134b3a0372b8)
3. Введите пароль пользователя. Учите, что введенные данные не показываются, поэтому я рекомендую просто вставить скопированный пароль, нажав правой кнопкой мыши в окне терминала
4. Запустите код скрипта:
```
sudo bash -c "$(curl -L https://raw.githubusercontent.com/Avonae/TS-Docker-Install/refs/heads/main/install_script.sh)"
```

Установка займет минут 5-10. После установки на экране появится длинная строка — это ключ администратора. Он-то нам и нужен:

![image](https://github.com/user-attachments/assets/2453b614-3528-46fa-969b-6ad8729ed836)

Если IP-адрес сервера на экране не совпадает с тем, по которому вы подключались — используйте адрес подключения.

На скриншоте `FlcTTMyfhoFvb1Ul4vIRmHITYXM1vJPZQ5C7FVn1` — этот токен. Его необходимо держать в секрете, я показываю для примера.

Далее установите клиент тимспика и подключитесь к своему серверу. У вашего сервера есть IP-адрес, его и вводите в поле для подключения:

![image](https://github.com/user-attachments/assets/bb30250a-70db-4a2f-97e6-52dcb71b55a2)

Пароль не вводите, нажимайте подключиться

После подключения сервер спросит у вас токен администратора. Скопируйте его из консоли и вставьте сюда:

![image](https://github.com/user-attachments/assets/3ea264e3-9496-494d-9c18-90486797bf16)

Нажмите ОК, ключ применится. 

![image](https://github.com/user-attachments/assets/c0626691-d166-439c-baa8-0847e849098c)

Ну вот и всё! Ваш сервер готов, а вы его администратор. Можете звать друзей, только установите пароль для начала.

# Настройка сервера
Для настройки сервера, нажмите на него правой кнопкой мыши → Редактировать виртуальный сервер

В первую очередь задайте пароль для сервера.

![image](https://github.com/user-attachments/assets/6416d247-8283-4310-a652-6491932cac83)

Теперь для подключения к серверу будет нужно указывать этот пароль.

## Настройка звука
Качества звука настраивается непосредственно в каналах. Поэтому для настройки, нажмите правой кнопкой на канал и выберите **Редактировать канал**

![image](https://github.com/user-attachments/assets/93105d2e-711c-41f2-a2aa-d62a15f09237)

На вкладке **Звук** можно выкрутить качество на **10**. Значение по умолчанию — 6. Я лично делаю это в первую очередь, т.к. качество просто потрясающее. Не зря же вы делали свой сервер! 
# Полезные команды
## Запуск докера не из под рута
Чтобы не писать `sudo` каждый раз, работая с докером, добавьте своего пользователя в группу `docker`:
```
sudo usermod -aG docker $USER
```
В инструкциях ниже докер запускается не от рута.
## Показать список запущенных контейнеров
```
docker ps
```
Первый столбец — ID контейнера. Скопируйте его, если хотите работать конкретно с ним. ID обычно выглядит как набор символов, вроде `90b8831a4a2`

## Перезапустить контейнер тим спика
```
docker restart ID_контейнера 
```
Здесь необходимо использовать ID контейнера, который вы получили с помощью `docker ps`.
## Перезапустить все контейнеры
```
docker restart $(docker ps -a -q)
```
## Удалить контейнер
```
docker rm ID_контейнера 
```
# Дополнительная информация
Если хотите управлять контейнерами, не заходя на сервер, а через удобный веб интерфейс, рассмотрите установку Portainer. Хорошая инструкция на русском [есть по ссылке](https://timeweb.cloud/tutorials/docker/ustanovka-i-ispolzovanie-portainer).

# Credits
В скрипте используется образ тимспика из репозитория [mbentley/docker-teamspeak](https://github.com/mbentley/docker-teamspeak)
