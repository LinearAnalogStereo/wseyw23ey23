#!/bin/bash

# Запуск Tor
tor --runasdaemon 1 --log notice file:/var/log/tor/log &
TOR_PID=$!

# Запуск Nginx
nginx -g "daemon off;" &
NGINX_PID=$!

# Логирование
tail -f /var/log/tor/log /var/log/nginx/access.log /var/log/nginx/error.log
