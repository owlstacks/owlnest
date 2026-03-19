FROM php:8.3-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    nginx \
    less \
    mysql-client \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    libzip-dev \
    icu-dev \
    imagemagick-dev \
    $PHPIZE_DEPS

# Configure and install PHP extensions
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        exif \
        gd \
        intl \
        mysqli \
        opcache \
        zip

# Install Imagick via PECL
RUN pecl install imagick && docker-php-ext-enable imagick

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Download WordPress
RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /tmp \
    && rm /tmp/wordpress.tar.gz

# Copy WordPress files into the web root
RUN mkdir -p /var/www/html \
    && cp -a /tmp/wordpress/. /var/www/html/ \
    && rm -rf /tmp/wordpress

# Set ownership
RUN chown -R www-data:www-data /var/www/html

# Copy entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]
