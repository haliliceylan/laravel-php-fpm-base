FROM php:7.3.15-fpm

#set our application folder as an environment variable
ENV APP_HOME /var/www/html
WORKDIR $APP_HOME
#install requirements
RUN apt-get update -y \
    && apt-get install -y \
      nginx \
      git \
      zip \
      zlib1g-dev \
      libzip-dev \
      unzip \
      libpng-dev \
      libjpeg-dev \
      libxml2-dev \
    && rm -r /var/lib/apt/lists/*

#conifgure extensions
RUN docker-php-ext-configure \
    gd --with-gd \
       --with-jpeg-dir=/usr/include/ \
       --with-png-dir=/usr/include/

#install extensions
RUN docker-php-ext-install \
      opcache \
      pdo_mysql \
      zip \
      bcmath \
      gd \
      soap

COPY php.ini /usr/local/etc/php/php.ini
COPY php-opocache-cfg.ini /usr/local/etc/php/conf.d/php-opocache-cfg.ini
COPY nginx-site.conf /etc/nginx/sites-enabled/default
COPY docker-entrypoint.sh /etc/entrypoint.sh

EXPOSE 80 443

CMD ["sh", "/etc/entrypoint.sh"]
