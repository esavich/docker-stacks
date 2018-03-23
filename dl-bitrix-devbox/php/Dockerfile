FROM php:7.0-apache as builder
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
ADD ../composer-installer.sh /tmp/composer-installer.sh
RUN chmod u+x /tmp/composer-installer.sh \
	&& /tmp/composer-installer.sh \
	&& cp /tmp/composer.phar /usr/local/bin/composer
ADD /etc/passwd /etc/passwd
ADD /etc/group /etc/group
USER ${USER:-tech}
WORKDIR /var/www/html
RUN composer -v

FROM php:7.0-apache
LABEL maintainer="Denis Pigalov <foritel@gmail.com>"
ADD --from=builder /tmp/composer.phar /usl/local/bin/composer
