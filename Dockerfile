# Étape 1 : Image PHP avec extensions nécessaires
FROM php:8.4-fpm

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    git unzip libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/projet

# Copier les fichiers du projet
COPY . .

# Installer les dépendances Symfony
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony
RUN git config --global user.email "you@example.com" \ && git config --global user.name "Your Name"
