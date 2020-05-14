FROM node:12.11.1-slim

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
        libgconf-2-4 \
        wget \
        fonts-ipafont-gothic \
        fonts-wqy-zenhei \
        fonts-thai-tlwg \
        fonts-kacst \
        ttf-freefont \
        tar \
        bzip2 \
        htop \
        curl \
        iputils-ping \
        git \
        parallel \
        ffmpeg \
    # installing chrome
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update && apt-get install -yq --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* \
    # chrome installed
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb \
    && yarn global add allure-commandline
