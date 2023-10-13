FROM php:8.1-fpm
LABEL maintainer="Jan Kozak <galvani78@gmail.com>"

# Configure
ENV NODE_MAJOR=20
ENV TZ=UTC

# Not really working as it is hardcoded bellow
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# System setup and dependencies
ARG DEBIAN_FRONTEND=noninteractive

# Do not ask me why this is needed, after migrating docker home this problem appeared
RUN chmod -R 777 /tmp

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

RUN echo "export LANGUAGE=en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
RUN apt-get install -y && locale-gen en_US.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Basic setup
RUN apt update && yes | apt install -y systemd ca-certificates curl gnupg && \
	mkdir -p /etc/apt/keyrings


RUN apt-get install --no-install-recommends -y \
	acl	\
	unzip \
	libicu-dev \
	libpng-dev \
	zlib1g-dev \
	libedit-dev \
	libxml2-dev \
	libxslt1-dev \
	zlib1g-dev libzip-dev\
	libc-client-dev \
	libkrb5-dev \
	curl \
	libcurl4-openssl-dev  \
	libonig-dev \
	wget \
	lsb-release \
	cron \
	libpq5 \
	libjpeg-dev \
	libjpeg62-turbo-dev \
	libwebp-dev \
	libgmp-dev \
	libldap2-dev \
	libc-client-dev \
	libkrb5-dev \
	netcat-traditional sqlite3 \
	libsqlite3-dev \
	iproute2 \
	net-tools \
	wget \
	vim \
	git \
	libz-dev \
    libpq-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libonig-dev \
	librabbitmq-dev \
	openssl

# Install GD extension
RUN docker-php-ext-configure gd --prefix=/usr --with-freetype --with-webp=  --with-jpeg \
    && docker-php-ext-install gd exif 

# Install libraries
RUN pecl channel-update pecl.php.net
RUN pecl install igbinary mongodb amqp xdebug
RUN pecl bundle redis && cd redis && phpize && ./configure --enable-redis-igbinary && make && make install
RUN docker-php-ext-enable igbinary redis mongodb amqp xdebug
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap
RUN docker-php-ext-install bcmath sockets mysqli gettext pdo bcmath intl mbstring soap xsl zip fileinfo
RUN docker-php-ext-install mysqli pdo_mysql

# Cleanup
RUN docker-php-source delete

# Configure PHP
RUN mkdir -p /var/run/php
COPY conf/php.ini /usr/local/etc/php/php.ini

# Configure xdebug
RUN echo xdebug.mode=debug >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo xdebug.start_with_request=yes >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.client_port=9003 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.remote.mode=req >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.remote.handler=dbgp >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo xdebug.client_host=`/sbin/ip route|awk '/default/ { print $3 }'` >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Cron for mautic
COPY conf /etc/cron.d/cron
RUN chmod 0755 /etc/cron.d/cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Install composer version 2
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Install GO for mn=hsendmail
COPY --from=golang:1.10 /usr/local/go /usr/local/go

# Setup email forwarding via postfix to mailhog
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' >> /usr/local/etc/php/php.ini

# Setup NodeJS version as in env
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update
RUN apt install nodejs -y

# Cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/cache/*

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]

