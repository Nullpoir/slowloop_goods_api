FROM node:16.15.0 as node
FROM ruby:3.1
ARG precompileassets
ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get install -y graphviz python python2 fonts-ipafont-gothic ghostscript

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN gem update debase-ruby_core_source
RUN gem install ruby-debug-ide -v '0.7.2'
RUN bundle install

COPY . /app

ARG RAILS_MASTER_KEY
ARG WEB_API_VERSION
ARG WEB_API_ENDPOINT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
