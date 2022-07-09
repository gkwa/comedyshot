#!/bin/bash

cd /tmp
rm -rf \
 /usr/local/src/composer \
 /tmp/compooser.phar \
 /tmp/composer \
 /usr/bin/composer \
 /usr/local/bin/composer
mkdir -p /usr/local/src/composer
php --version
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
mv composer.phar composer
getent passwd | grep www-data
chown www-data:www-data composer
chmod u+s /tmp/composer
chmod g+s /tmp/composer
chmod g+x /tmp/composer
chmod u+x /tmp/composer
mv /tmp/composer /usr/local/src/composer/composer
ls -la /usr/local/src/composer/composer
cat <<'__eot__' >/usr/local/src/composer/wrapper
sudo --user=www-data /usr/local/src/composer/composer
__eot__
chmod +x /usr/local/src/composer/wrapper
ls -la /usr/local/src/composer/wrapper
ln -fs /usr/local/src/composer/wrapper /usr/local/bin/composer
ls -la \
 /usr/local/src/composer/composer \
 /usr/local/src/composer/wrapper \
 /usr/local/bin/composer
composer --version
