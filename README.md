# Docker composer environment for Mautic Development

Docker composer environment, all mautic files are located in **mautic** directory

## How to install

 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8088/index_dev.php

## Check .env for more details

## Post-install actions (will be automated in the future)
> @todo - npm even when installed just won't compile
```
docker compose exec php apt update && 
docker compose exec php apt install npm -y --no-install-recommends
docker compose exec php composer install
```

## Installed containers

| Name         | Image               | Ports |
|--------------|---------------------|-------|
| **rabbitmq** | rabbitmq:latest     | .env  |
| **redis**    | redis:latest        |       |
| **mysql**    | mysql               |       |
| **php**      | galvani/phpfony:8.0 |       |


