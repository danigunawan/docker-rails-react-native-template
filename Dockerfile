FROM ruby:2.5.3

ENV APP_ROOT /work/myspace

WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install -y nodejs \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY . $APP_ROOT