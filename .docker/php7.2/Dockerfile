FROM ubuntu:18.04

EXPOSE 9000

ADD ./conf/www-pool.conf /etc/php/7.2/fpm/pool.d/www-docker.conf

# Install modules
RUN apt-get update

RUN apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN yes | apt-get install software-properties-common software-properties-common
RUN yes | add-apt-repository ppa:ondrej/php
RUN yes | apt-get install systemd
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 11CD8CFCEEB5E8F4
RUN apt-get update && apt-get install -y php-apcu php-mailparse php-pear php7.2-bcmath php7.2-cli php7.2-common php7.2-curl php7.2-dev php7.2-fpm \
    php7.2-gd php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap \
    php7.2-xml php7.2-xmlrpc php7.2-xsl php7.2-zip

RUN apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	mysql-client \
	libxml2-dev \
	zlib1g-dev \
	libc-client-dev libkrb5-dev \
	curl wget php-mailparse
	
RUN echo 'deb http://s3-eu-west-1.amazonaws.com/tideways/packages debian main' > /etc/apt/sources.list.d/tideways.list
RUN apt-get update
RUN wget -qO - https://s3-eu-west-1.amazonaws.com/tideways/packages/EEB5E8F4.gpg | apt-key add -

# install tideways

RUN apt-get install -y vim git

RUN mkdir -p /var/run/php

RUN apt-get install -y wget lsb-release
RUN apt-get -y install cron

# Enable xdebug
RUN apt-get install php-xdebug \
    && echo "zend_extension=$(find /usr/lib -name xdebug.so | tail -n2 | head -n1)" > /etc/php/7.2/fpm/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /etc/php/7.2/fpm/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /etc/php/7.2/fpm/conf.d/xdebug.ini

COPY ./conf/cron/mautic /etc/cron.d/mautic
RUN chmod 0755 /etc/cron.d/mautic

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '106d3d32cc30011325228b9272424c1941ad75207cb5244bee161e5f9906b0edf07ab2a733e8a1c945173eb9b1966197') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin && chmod 755 /usr/bin/composer.phar
RUN php -r "unlink('composer-setup.php');"
RUN ln -s /usr/bin/composer.phar /usr/bin/composer

CMD ["chmod -R 0777 /var/www/mautic-cloud/app/cache /var/www/mautic-cloud/app/logs"]
CMD ["chmod -R 0777 /var/www/mautic-os/app/cache /var/www/mautic-os/app/logs"]

RUN find / -name "php-fpm*"

RUN rm /etc/php/7.2/fpm/pool.d/www.conf
RUN rm /etc/php/7.2/fpm/php.ini
RUN rm /etc/php/7.2/cli/php.ini
COPY ./conf/php.ini /etc/php/7.2/fpm/php.ini
COPY ./conf/php.ini /etc/php/7.2/cli/php.ini

# Add sendmail to mailhog
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq postfix
RUN rm /etc/postfix/main.cf
COPY ./conf/mail/main.cf /etc/postfix/main.cf

RUN rm -f /var/spool/postfix/etc/hosts /var/spool/postfix/etc/resolv.conf
RUN ln -s /etc/hosts /var/spool/postfix/etc/hosts
RUN ln -s /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

RUN systemctl enable postfix
COPY ./launcher.sh /usr/bin/postfix-launcher
RUN chmod 755 /usr/bin/postfix-launcher

# Run the command on container startup
CMD ["postfix-launcher", "/usr/sbin/php-fpm7.2", "-F"]
