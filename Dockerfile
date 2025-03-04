# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем переменные окружения для избежания вопросов при установке пакетов
ENV DEBIAN_FRONTEND=noninteractive

# Добавляем репозиторий deadsnakes для Python 3.12
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# Обновляем пакеты и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    wget \
    git \
    dos2unix \
    gcc \ 
    libsodium-dev \
    libc6-dev \
    make \
    build-essential \
    automake \
    autoconf \
    libtool \
    libevent-dev \
    libssl-dev \
    zlib1g-dev \
    libcap-dev \
    libseccomp-dev \
    pkg-config \
    asciidoc \
    python3.12 \
    python3.12-dev \
    python3.12-venv \
    nginx \
    ranger \
    obfs4proxy \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Tor из исходников
WORKDIR /opt
RUN git clone https://gitlab.com/torproject/tor.git
WORKDIR /opt/tor
RUN ./autogen.sh && ./configure --disable-asciidoc && make && make install

# Создаем директорию /etc/tor, если она не существует
RUN mkdir -p /etc/tor
RUN mkdir -p /usr/local/var
RUN mkdir -p /usr/local/var/lib
RUN mkdir -p /usr/local/var/lib/tor
#RUN mkdir =p /usr/local/etc/tor/

# Загружаем ваш конфигурационный файл torrc
RUN wget https://raw.githubusercontent.com/LinearAnalogStereo/wseyw23ey23/main/torrc -O /usr/local/etc/tor/torrc

# Загружаем ваш конфигурационный файл nginx.conf
RUN wget https://raw.githubusercontent.com/LinearAnalogStereo/wseyw23ey23/main/nginx.conf -O /etc/nginx/nginx.conf

# Загружаем ваш скрипт start.sh
RUN wget https://raw.githubusercontent.com/LinearAnalogStereo/wseyw23ey23/main/start.sh -O /start.sh
RUN dos2unix /start.sh
RUN chmod +x /start.sh
RUN mv /var/www/html/* /var/www/html/index.html

# Копируем mkp224o (без запуска)
WORKDIR /opt
RUN git clone https://github.com/cathugger/mkp224o.git
WORKDIR /opt/mkp224o
RUN ./autogen.sh && ./configure && make

# Открываем порты
EXPOSE 80
EXPOSE 9050

# Запускаем скрипт при старте контейнера
CMD ["/start.sh"]
