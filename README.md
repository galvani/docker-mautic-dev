# Docker composer environment for Mautic Development

Docker composer environment, all mautic files are located in **mautic** directory

## How to install

 * clone this repository
 * cd into the directory and run: ```git submodule init && git submodule update``` to checkout the current mautic version
 * run ```docker-compose up``` the containers will get created and started
 * navigate to: http://localhost:8888/

## Check .env for more details

## Post-install actions (will be automated in the future)

### Install vendors and compile assets

```
docker compose exec php composer install && chmod -R 777 var/*
```

## Shell should not load xdebug
```shell
XDEBUG_MODE=off composer -v require symfony/amqp-messenger
```

## Installed containers

| Name         | Image               | Ports |
|--------------|---------------------|-------|
| **rabbitmq** | rabbitmq:latest     | .env  |
| **redis**    | redis:latest        |       |
| **mysql**    | mysql               |       |
| **php**      | galvani/phpfony:8.0 |       |


