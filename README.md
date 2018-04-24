# Docker composer environment for Mautic Development

Docker composer environment, all mautic files are located in **mautic** directory

## How to install

 > Check docker-compose.yml to select correct PHP version and check configi values of interest.

 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8080/index_dev.php

### Troubleshoot

In case you get access forbidden on mautic you might need to specify the IP of docker machine in file ```docker-compose.yml```, also **xdebug** configuration is provided to enable xdebug in your ide.

```
  phpfpm:
    restart: always
    build: .docker/php7.1
    volumes:
      - './.docker/php/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf'
      - './.docker/php/conf/php.ini:/usr/local/etc/php/php.ini'
      - './mautic:/var/www/html'
      - './mautic-hosted:/var/www/html-hosted'
      - './var/log/php-fpm:/var/log/php-fpm'
      - './var/mail:/var/spool/mail'
      - 'userroot:/root'
    links:
      - 'db:mysqldb'
      - 'mailhog:mail'
      - 'beanstalkd:beanstalkd'
      - 'redis:redis'
    environment:
      MAUTIC_DEV_HOSTS: HERE_DOCKER_MACHINE_IP
      XDEBUG_CONFIG: remote_host=HERE_DOCKER_MACHINE_IP
```

**You need to adjust vhsot.conf too.** This will be unified and made to tell the machine ip it self. Anyone can do it.

## How to reset

Use ```docker-compose down``` which should delete all containers, there are still compiled images present though.

## Docker containers

* PHP 7.1 CLI/FPM (Optional PHP 7.2) **exposed only to docker containers**
* Mailhog - configured as mailserver for php container **exposed web interface on host port 8025**
* MySQL 5.7 - database server, **exposed on host port 3307, internaly 3306**
* nginx:latest webserver - **exposed on host port 8080**
* beanstalkd **exposed on host port and internaly 11300**
* beanstalkd console **exposed on host port 2080**
* Redis server **exposed on host port 6379***

## How to connect to services

 * **phpfpm** is the hostname of php
 * **mysqldb** is the hostname of mysql server
 
 
