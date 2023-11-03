# Docker-compose for Mautic development environment

Docker composer environment, all mautic files are located in **mautic** directory

## How to install

### Configure
 * clone this repository
 * alter the .env file https://github.com/galvani/docker-mautic-dev/blob/master/.env
 * run ```docker-compose up``` the containers will get created and started

## Post-install actions (will be automated in the future)
 * install composer dependencies and generate assets with `docker-compose exec php composer install`

## Troubleshooting

 **shell should not load xdebug** `XDEBUG_MODE=off composer -v require symfony/amqp-messenger`
 **xdebug not connecting** - try: `export PHP_IDE_CONFIG="serverName=localhost" && php -dxdebug.mode=debug -dxdebug.client_port=9003 -dxdebug.start_with_request=yes bin/console`

