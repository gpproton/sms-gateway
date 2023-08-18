FROM php:7.4-fpm

RUN apt-get update

RUN apt-get install -y \
    git \
    libzip-dev \
    procps \
    rsync \
    unzip \
    && docker-php-ext-install zip

# Install MySQL
RUN docker-php-ext-configure mysqli -with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql -with-pdo-mysql=mysqlnd \
    && docker-php-ext-install pdo pdo_mysql mysqli

# Install GD
RUN apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxpm-dev

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ \
    --with-xpm=/usr/include/ \
    --enable-gd-jis-conv \
    && docker-php-ext-install gd


# Install xdebug
RUN pecl install xdebug-3.0.4 \
    && docker-php-ext-enable xdebug

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY config/php.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html
RUN mkdir /var/www/scripts
COPY entrypoint.sh /var/www/scripts/entrypoint.sh
COPY install.php /var/www/scripts/install.php
ENTRYPOINT [ "bash", "/var/www/scripts/entrypoint.sh" ]