# Symfony dev image: PHP 8.4 CLI + zpinit as PID 1 (supervise mode).
#
# Supervise mode (no CMD): zpinit runs entrypoint.d/ (composer install) then
# supervises services/ (the Symfony dev server). A server crash keeps zpinit
# PID 1 and the container up, so `zdev exec` still works — recoverable in place.
#
# Everything the old inline `command:`/setup.just installed at runtime is baked
# here instead, so it survives container recreates and isn't re-downloaded on
# every boot: PHP extensions, composer, and the Symfony CLI.
FROM php:8.4-cli-alpine

# zpinit (PID 1) + zpctl (operator CLI, for `zdev exec app zpctl restart app`).
COPY --from=ghcr.io/0ploy/zpinit:latest /usr/local/bin/zpinit /usr/local/bin/
COPY --from=ghcr.io/0ploy/zpinit:latest /usr/local/bin/zpctl  /usr/local/bin/

# composer (phar, runs on any PHP).
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# PHP extensions (install-php-extensions resolves each one's build deps).
ADD --chmod=755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions intl pdo_mysql opcache zip

# bash + git (symfony CLI installer needs bash; composer/git for VCS deps), then
# bake the Symfony CLI. memory_limit=-1 so composer/cache:clear don't OOM.
RUN apk add --no-cache bash git \
 && wget -qO- https://get.symfony.com/cli/installer | bash \
 && mv "$HOME/.symfony5/bin/symfony" /usr/local/bin/symfony \
 && printf 'memory_limit=-1\n' > /usr/local/etc/php/conf.d/zz-app.ini

COPY .zdev/zpinit/ /etc/zpinit/

WORKDIR /app
# No CMD -> zpinit runs entrypoint.d/ then supervises services/ (mode 3).
ENTRYPOINT ["zpinit"]
