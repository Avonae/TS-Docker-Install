Русскую инструкцию [смотрите по ссылке.](https://github.com/Avonae/TS-Docker-Install/blob/main/README-Ru.md)

# Creating your own TeamSpeak server 

Discord has been blocked in Russia. The legends didn’t lie... I didn’t like it before, and I definitely don’t want to use it through a VPN. So, I decided to set up my own TeamSpeak server and try to bring back the spirit of the 2000s.
Along the way, I created a script that installs a TeamSpeak server in one command. I'm sharing it with you.

# Why TeamSpeak?

Here’s why I like my own TeamSpeak server:

No need to mess with VPNs or other ways to bypass blocks.
Better sound quality and lower ping to the server. TeamSpeak gives us audio at up to 100 Kb/s, while free Discord only offers 64 Kb/s.
With your own server, you can do whatever you want and even set up multiple services.
[A personal bonus for me] [Discord is laggy](https://windowsreport.com/discord-website-defaults-32-bit-app-how-to-download-64-bit/) and always has some sound issues, and only there, nowhere else. In short, I wouldn’t say TeamSpeak is a full replacement for Discord. It only has voice and text chats. You won’t find popular Discord servers or emojis here. But if communicating with friends is your main goal, this is the option for you.

# Setting Up the Server
First, you’ll need to rent a [VPS](https://ru.wikipedia.org/wiki/VPS) (Virtual Private Server). It’s inexpensive — prices start at around 4$ a month. I recommend going for large companies with good reviews.
You can use the server for other tasks like VPN later.

## Installation
We’ll be using [Docker](https://en.wikipedia.org/wiki/Docker_(software)), to avoid cluttering up the system. After purchasing the VPS, you will receive the server’s IP address and login credentials.
Open a terminal (not CMD, but a proper terminal).

![Open windows terminal](https://github.com/user-attachments/assets/033e9d29-bab5-4168-88ee-4de534f5586c)

Enter the command `ssh username@IP_address_your_server`, for example:

```bash
ssh alex@192.168.31.180
```

Type `yes`, to accept the server’s certificate.

![image](https://github.com/user-attachments/assets/b6d021d1-69c0-4710-8a4c-134b3a0372b8)

Enter the user password provided when you rented the VPS. Keep in mind that for security reasons, the entered characters won’t be displayed, so it’s easier to copy and paste it.

![image1](https://github.com/user-attachments/assets/87df91c9-0345-466c-8da4-1843b7aad907)

Run the installation script:

```bash
sudo bash -c "$(curl -L https://raw.githubusercontent.com/Avonae/TS-Docker-Install/refs/heads/main/install_script.sh)"
```
The installation will take 5-10 minutes. Once completed, an admin token will appear on the screen, which we’ll need later.

![The server is ready](https://github.com/user-attachments/assets/b6a937d2-d14e-4544-93ca-4f0530f0b226)

The server is ready, you can connect now.

## Connecting and Setting Up
Install the [Teamspeak Client](https://teamspeak.com/en/downloads/). I like the old version 3, but you can also use the current version 5.

To connect, enter the VPS IP address in the server address field. Leave the password field empty and set any nickname you like.

![Enter the server address in Teamspeak Client](https://github.com/user-attachments/assets/8080c6ca-62da-4e9d-bff9-8e2399506932)

On your first connection, you’ll be asked for the admin token. Copy it from the console and press OK:

![Enter the admin token](https://github.com/user-attachments/assets/6da8fe40-5531-4549-b0bb-f120eb52f3b8)

Done! You are now the server admin.

![Admin key applied succefully](https://github.com/user-attachments/assets/b4400bbf-310a-498b-bef2-964e9226ae20)

Everything is set up, but I recommend changing the server password. To do this, right-click on the server and select "Edit Virtual Server," then set a password.

![Change the server passoword](https://github.com/user-attachments/assets/10845523-256e-4828-9d8e-5cc018c7951a)

I also suggest maxing out the sound quality. You can do this in the channel settings. Set it to 10 right away to feel the difference from Discord.

That’s it! The server is ready — you can invite your friends. If you have any questions, feel free to ask in issue.

# FAQ
## Why is your server’s IP local?
In the guide, I used a virtual machine because I already have a working TeamSpeak server, and I don’t want to delete it.

## What exactly does your script do?
You can find the script’s code with comments [in the repository.](https://github.com/Avonae/TS-Docker-Install). 

## What else can you do on the server?
You can add a domain and connect to the server using a nice URL, install [Portainer](https://www.portainer.io/), and much more...

## How do I delete the server?

First, list the active containers with the command `docker ps`

![Output of "docker ps" command](https://github.com/user-attachments/assets/2054f8d3-5f80-4c6f-9c26-1a98efc68698)

Then remove the container with the command `docker rm -f container_ID`, in my case:

![Deleted container](https://github.com/user-attachments/assets/03fa3a65-73cd-4bd4-adba-d93ff6a0aaca)

The container will be stopped and deleted. You can reinstall the server with the same script.

# Useful commands and FAQ

## Running Docker without root

To avoid using `sudo` every time you work with docker, add your user to the `docker` group:

```
sudo usermod -aG docker $USER
```

In the instructions below, docker is runnig without root.

## Show the list of running containers

```
docker ps
```

The first column is the ID of the container. Copy it if you want to work specifically with it. The ID usually looks like a set of characters, like `90b8831a4a2`.

## Restart the TeamSpeak container

```
docker restart Container_ID 
```

Here you need to use the container ID you got with `docker ps`.

## Restart all containers

```
docker restart $(docker ps -a -q)
```

## Delete containers

Start with `docker ps`
![image](https://github.com/user-attachments/assets/2054f8d3-5f80-4c6f-9c26-1a98efc68698)
потом

```
docker rm Container_ID 
```

![image](https://github.com/user-attachments/assets/03fa3a65-73cd-4bd4-adba-d93ff6a0aaca)

Container has been deleted.

## Why is your server’s IP local?
In the guide, I used a virtual machine because I already have a working TeamSpeak server, and I don’t want to delete it.

## What else can you do on the server?
You can add a domain and connect to the server using a nice URL, install [Portainer](https://www.portainer.io/), and much more...

# Credits

The script uses a TeamSpeak image from the repository [mbentley/docker-teamspeak](https://github.com/mbentley/docker-teamspeak)
