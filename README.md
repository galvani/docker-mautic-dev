# mautic-docker
Docker composer environment, all mautic files are located in **mautic** directory

## How to install
 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8080/index_dev.php
 * 
 

**Consists of following docker containers:**
* PHP 7.1 CLI/FPM
* Mailhog - configured as mailserver for php container **exposed web interface on 8025**
* MySQL 5.7 - database server, **exposed on 3307**
* nginx webserver - **exposed and configuredon port 8080**
