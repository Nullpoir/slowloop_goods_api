FROM node:16.15.0 as node
FROM ruby:3.1
ARG precompileassets
ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get install -y graphviz python python2 fonts-ipafont-gothic ghostscript

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN gem update debase-ruby_core_source
RUN gem install ruby-debug-ide -v '0.7.2'
RUN bundle install

COPY package.json yarn.lock /app/
RUN yarn install --check-files

COPY . /app

ARG RAILS_MASTER_KEY

COPY asset_precompile.sh /usr/bin/
RUN chmod +x /usr/bin/asset_precompile.sh
RUN asset_precompile.sh $precompileassets

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
