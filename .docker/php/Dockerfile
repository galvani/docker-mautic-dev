FROM php:5.6-fpm
# Install modules
RUN apt-get update && apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	mysql-client \
	libxml2-dev \
	zlib1g-dev \
	libc-client-dev libkrb5-dev \
	php5-cli
RUN apt-get install -y vim
RUN docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install iconv \
	&& docker-php-ext-configure imap --with-kerberos --with-imap --with-imap-ssl \
    && docker-php-ext-install imap \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install mysql \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install xml \
	&& docker-php-ext-install zip
RUN apt-get install -y wget lsb-release
RUN apt-get -y install cron

# Enable xdebug
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

COPY ./conf/cron/mautic /etc/cron.d/mautic
RUN chmod 0755 /etc/cron.d/mautic

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
# CMD cron && tail -f /var/log/cron.log
CMD ["php-fpm"]