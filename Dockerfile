FROM node:14.2.0-slim

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
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
    # installing chrome
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update && apt-get install -yq --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* \
    # chrome installed
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb \
    && yarn global add allure-commandline
