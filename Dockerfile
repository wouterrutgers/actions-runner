FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        wget \
        curl \
        git \
        unzip \
        gnupg2 \
        lsb-release \
        ca-certificates \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libzip-dev \
        libonig-dev \
        libxml2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libicu-dev \
        libmcrypt-dev \
        libreadline-dev \
        zlib1g-dev \
        mysql-client \
        sudo \
        xvfb \
        && rm -rf /var/lib/apt/lists/*

# Install PHP 8.2 and extensions
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        php8.2 \
        php8.2-cli \
        php8.2-fpm \
        php8.2-mbstring \
        php8.2-xml \
        php8.2-pdo \
        php8.2-mysql \
        php8.2-sqlite \
        php8.2-zip \
        php8.2-gd \
        php8.2-curl \
        php8.2-intl \
        php8.2-bcmath \
        php8.2-readline \
        php8.2-pcov \
        && rm -rf /var/lib/apt/lists/*

# Set up PHP CLI as default
RUN update-alternatives --set php /usr/bin/php8.2

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node.js 16 and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Set up locales (optional, often needed for Composer or PHPUnit output)
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Set working directory
WORKDIR /app

# Default command
CMD ["bash"]
