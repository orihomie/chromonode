FROM node:14.17.1-slim

ARG CHROME_VERSION="google-chrome-stable"
ARG FIREFOX_VERSION=76.0

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt-get -qqy update \
    && apt-get install -qqy --no-install-recommends \
        jq \
        zip \
        xvfb \
        pulseaudio \
        g++ \
        gnupg2 \
        build-essential \
        dbus \
        dbus-x11 \
        xz-utils \
        ca-certificates \
        git \
        tar \
        curl \
        htop \
        wget \
        bzip2 \
        gnupg2 \
        ffmpeg \
        parallel \
        libgconf-2-4 \
        iputils-ping \
        ttf-freefont \
        fonts-kacst \
        fonts-thai-tlwg \
        fonts-wqy-zenhei \
        fonts-ipafont-gothic \
#    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb \
    && yarn global add allure-commandline

ENV FFMPEG_PATH /usr/bin/ffmpeg

#
# FIX X11
#
RUN mkdir /tmp/.X11-unix | true && \
    chown -R root:root /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix

#
# CHROME
#
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qqy && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable} && \
    rm /etc/apt/sources.list.d/google-chrome.list && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    ln -s /usr/bin/google-chrome /usr/bin/chromium-browser

#
# FIREFOX - Stable v76 ...
#
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    apt-get -qqy update \
    && apt-get -qqy install libgtk-3-0 libx11-xcb1 libdbus-glib-1-2 libxt6 && \
    curl -o /opt/firefox-$FIREFOX_VERSION.tar.bz2 "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/de/firefox-${FIREFOX_VERSION}.tar.bz2" && \
    tar xfv /opt/firefox-$FIREFOX_VERSION.tar.bz2 -C /opt/ && \
    rm -f /opt/firefox-$FIREFOX_VERSION.tar.bz2 && \
    ln -s /opt/firefox/firefox /usr/local/bin/firefox
