# Docker composer environment for Mautic Development

## If  you like this; star it, please.

Docker composer environment, all mautic files are located in **mautic** directory

Do not use **localhost** to connect to mysql db. Use IP address of localhost instead: **127.0.0.1**

## How to install

 > Check docker-compose.yml to select correct PHP version and check config values of interest.

 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8088/index_dev.php

## Configuring Mautic

Run ```composer.phar``` in phpfpm container. Bash into the container: ```docker exec -it containerName bash```. To list runing containers use ```docker ps```, the container name is at the end of each row.

If configuring fresh Mautic installation; on startup you may get an error on **/index.php/installer**, you just need to change it to **/installer** once again and everything will work as expected. This is something in nginx configuration I didn't find important enough to fix. Feel free to do so.

Root mysql password can be found in **composer.yml**

### Troubleshooting

#### Windows & GIT
You need to adjust you git config not to transform line endings. Please use

```git clone https://github.com/galvani/mautic-docker.git --config core.autocrlf=input```


Docker machine must be **VirtualBox not HyperV** otherwise local folder wont't get mounted into the container.

In case you get access forbidden on mautic you might need to specify the IP of docker machine in file ```docker-compose.yml```, also **xdebug** configuration is provided to enable xdebug in your ide.


**You need to adjust vhost.conf too.** This will be unified and made to tell the machine ip it self. Anyone can do it.

## How to reset

Use ```docker-compose down``` which should delete all containers, there are still compiled images present though.

## How to build changed image into container

Use ```docker-compose build phpfpm```. If wish to download the sources again use the ```--no-cache``` parameter.

## Docker containers

* PHP 7.2 CLI/FPM**exposed only to docker containers**
* Mailhog - configured as mailserver for php container **exposed web interface on host port 8025**
* MySQL 5.7 - database server, **exposed on host port 3307, internaly 3306**
* nginx:latest webserver - **exposed on host port 8080**
* Redis server **exposed on host port 6379***
* CrateDB **exposed only to docker containers**

## How to connect to services

 * **phpfpm** is the hostname of php
 * **mysqldb** is the hostname of mysql server
 
 
