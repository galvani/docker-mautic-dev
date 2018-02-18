FROM ubuntu:17.10

EXPOSE 9000

ADD ./conf/www-pool.conf /etc/php/7.1/fpm/pool.d/www-docker.conf

# Install modules
RUN apt-get update

RUN apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN yes | apt-get install software-properties-common python-software-properties
RUN yes | add-apt-repository ppa:ondrej/php

RUN apt-get install -y php-apcu php-mailparse php-pear php7.1-bcmath php7.1-cli php7.1-common php7.1-curl php7.1-dev php7.1-fpm \
    php7.1-gd php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-opcache php7.1-readline php7.1-soap \
    php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip

RUN apt-get update && apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	mysql-client \
	libxml2-dev \
	zlib1g-dev \
	libc-client-dev libkrb5-dev \
	curl

RUN apt-get install -y vim git

RUN mkdir -p /var/run/php

RUN apt-get install -y wget lsb-release
RUN apt-get -y install cron

# Enable xdebug
# RUN yes | pecl install xdebug \
#     && echo "zend_extension=$(find /usr/lib -name xdebug.so)" > /etc/php/7.1/fpm/conf.d/xdebug.ini \
#     && echo "xdebug.remote_enable=on" >> /etc/php/7.1/fpm/conf.d/xdebug.ini \
#     && echo "xdebug.remote_autostart=off" >> /etc/php/7.1/fpm/conf.d/xdebug.ini

# Enable xdebug
RUN apt-get install php-xdebug \
&& echo "zend_extension=$(find /usr/lib -name xdebug.so)" > /etc/php/7.1/fpm/conf.d/xdebug.ini \
     && echo "xdebug.remote_enable=on" >> /etc/php/7.1/fpm/conf.d/xdebug.ini \
     && echo "xdebug.remote_autostart=off" >> /etc/php/7.1/fpm/conf.d/xdebug.ini

COPY ./conf/cron/mautic /etc/cron.d/mautic
RUN chmod 0755 /etc/cron.d/mautic

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin && chmod 755 /usr/bin/composer.phar
RUN php -r "unlink('composer-setup.php');"

CMD ["chmod -R 0777 /var/www/html/app/cache /var/www/html/app/logs"]

RUN find / -name "php-fpm*"

RUN rm /etc/php/7.1/fpm/pool.d/www.conf

# Run the command on container startup
# CMD cron && tail -f /var/log/cron.log
CMD ["/usr/sbin/php-fpm7.1", "-F"]