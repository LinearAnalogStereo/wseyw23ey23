#!/bin/bash

# Запуск Tor
tor --runasdaemon 1 --log "notice file /var/log/tor/log" &
TOR_PID=$!

# Ждем, пока Tor создаст файл с onion-адресом
while [ ! -f /usr/local/var/lib/tor/hidden_service/hostname ]; do
    echo "Ожидание создания onion-адреса..."
    sleep 1
done

# Выводим onion-адрес
ONION_ADDRESS=$(cat /usr/local/var/lib/tor/hidden_service/hostname)
echo "Onion-адрес: $ONION_ADDRESS"

# Запуск Nginx
nginx -g "daemon off;" &
NGINX_PID=$!

# Логирование
tail -f /var/log/tor/log /var/log/nginx/access.log /var/log/nginx/error.log
