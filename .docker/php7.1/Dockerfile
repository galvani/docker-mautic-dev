
#################################### # PHPDocker.io PHP 7.1 / CLI image # #################################### 
FROM ubuntu:xenial

 # Fixes some weird terminal issues such as broken clear / CTRL+L 
 ENV TERM=linux 
 RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install git curl ca-certificates \
        php7.1-cli php7.1-curl php-apcu php-apcu-bc \
        php7.1-json php-sodium php7.1-mbstring php7.1-opcache php7.1-readline php7.1-xml php7.1-zip \
		php7.1-mysql php7.1-redis \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer
RUN apt-get update

RUN apt-get install -y locales

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN yes | apt-get install software-properties-common python-software-properties
RUN yes | add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y php-apcu php-mailparse php-pear php7.1-bcmath php7.1-cli php7.1-common php7.1-curl php7.1-dev php7.1-fpm \
    php7.1-gd php7.1-intl php7.1-json php7.1-mbstring php7.1-mysql php7.1-opcache php7.1-readline php7.1-soap \
    php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php7.1-mcrypt

# Enable xdebug
RUN apt-get install php-xdebug \
    && echo "zend_extension=$(find /usr/lib -name xdebug.so | tail -n2 | head -n1)" > /etc/php/7.1/fpm/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /etc/php/7.1/fpm/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /etc/php/7.1/fpm/conf.d/xdebug.ini

CMD ["tail", "-f", "/dev/null"] 