#!/usr/bin/env bash
#php artisan down --message="Project is Updating" --retry=10
php artisan migrate --force
#php artisan optimize
#php artisan queue:restart
#php artisan up
service nginx start
php-fpm