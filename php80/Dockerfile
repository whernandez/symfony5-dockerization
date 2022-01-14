FROM php:8.0.1-fpm

LABEL maintainer="Wandy Hernandez <https://whernandez.github.io/my-portfolio/>"

# Install packages and PHP extensions
RUN apt-get update && apt-get install -y zlib1g-dev g++ git wget nano libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# Install and update composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer self-update

# Install PHP-CS-FIXER
RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O php-cs-fixer
RUN chmod a+x php-cs-fixer
RUN mv php-cs-fixer /usr/local/bin/php-cs-fixer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Copy configuration
COPY ./custom.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/app
