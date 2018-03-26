FROM php:7.0-apache as builder
WORKDIR /tmp
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
		sendmail \
		wget \
	&& docker-php-ext-install -j$(nproc) mcrypt opcache pdo_mysql mysqli zip \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd
COPY ./composer-installer.sh ./composer-installer.sh
RUN chmod u+x ./composer-installer.sh \
	&& ./composer-installer.sh \
	&& mv ./composer.phar /usr/local/bin/composer
WORKDIR /var/www/html
RUN composer -v

FROM php:7.0-apache
LABEL maintainer="Denis Pigalov <foritel@gmail.com>"
COPY --from=builder /usr/local/bin/composer /usl/local/bin/composer
RUN chmod -R 2775 /var/www/html
