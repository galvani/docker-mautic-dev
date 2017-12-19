FROM php:5.6-fpm
# Install modules
RUN apt-get update && apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	mysql-client \
	libxml2-dev \
	zlib1g-dev \
	libc-client-dev libkrb5-dev \
	&& docker-php-ext-install pdo_mysql \
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
RUN wget http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb
RUN dpkg -i mysql-apt-config_0.7.3-1_all.deb
CMD ["php-fpm"]