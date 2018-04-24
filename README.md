# Docker composer environment for Mautic Development

Docker composer environment, all mautic files are located in **mautic** directory

## How to install

 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8080/index_dev.php

## How to reset

Use ```docker-compose down``` which should delete all containers, there are still compiled images present though.

## Docker containers

* PHP 7.1 CLI/FPM (Optional PHP 7.2)
* Mailhog - configured as mailserver for php container **exposed web interface on 8025**
* MySQL 5.7 - database server, **exposed on 3307**
* nginx:latest webserver - **exposed and configuredon port 8080**
* beanstalkd

## How to connect to services

 * **phpfpm** is the hostname of php
 * **mysqldb** is the hostname of mysql server
 
 
