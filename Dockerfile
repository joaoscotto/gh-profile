# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.4.7
FROM ruby:$RUBY_VERSION-slim

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      git \
      libyaml-dev \
      libjemalloc2 \
      libvips \
      libvips-dev \
      sqlite3 \
      nodejs \
      npm \
      wget \
      unzip \
      libx11-xcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxi6 libxrandr2 libxrender1 libxtst6 \
      libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgbm1 libgtk-3-0 libnss3 libpango-1.0-0 libxss1 \
      libasound2 fonts-liberation libwoff1 libharfbuzz0b libfribidi0 libglib2.0-0 ca-certificates \
      gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
      gstreamer1.0-libav gstreamer1.0-tools libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 \
      libvulkan1 libxslt1.1 libopus0 libavif16 libenchant-2-2 libsecret-1-0 \
      libhyphen0 \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY package*.json ./
RUN npm install playwright
RUN ./node_modules/.bin/playwright install

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
