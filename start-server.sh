#!/bin/bash

# Заменяем плейсхолдер в индекс на хостнейм
sed -i "s/HOSTNAME/$(hostname)/" /etc/nginx/conf.d/conf.conf
sed -i "s/HOSTNAME/$(hostname)/" /usr/share/nginx/html/index.html

# старт сервера
nginx -g "daemon off;"
