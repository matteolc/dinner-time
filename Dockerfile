FROM ruby:3-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    gawk \
    bison \
    libgdbm-dev \
    libgmp-dev \
    libreadline6-dev

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" | tee /etc/apt/sources.list.d/postgresql.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && \
    apt-get install -y \
    postgresql-client-14 \
    git \
    build-essential \
    libpq-dev

WORKDIR /app 

VOLUME ["/usr/local/bundle"]
COPY Gemfile ./
RUN bundle install

RUN wget --quiet -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y yarn

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]