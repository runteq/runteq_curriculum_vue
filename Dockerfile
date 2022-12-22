ARG APP_NAME=runteq_curriculum_vue
ARG RUBY_IMAGE=ruby:2.6.5
ARG NODE_VERSION='15'
#インストールするbundlerのversionに置き換えてください
ARG BUNDLER_VERSION=2.2.27

FROM $RUBY_IMAGE
ARG APP_NAME
ARG RUBY_VERSION
ARG NODE_VERSION
ARG BUNDLER_VERSION

ENV RAILS_ENV production
ENV RAILS_MASTER_KEY e3c0406397e8f960e7e165206d57b579
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_WITHOUT development:test
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

RUN echo $RAILS_ENV

RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn

RUN gem install bundler:$BUNDLER_VERSION

COPY Gemfile /$APP_NAME/Gemfile
COPY Gemfile.lock /$APP_NAME/Gemfile.lock

RUN bundle install

COPY yarn.lock /$APP_NAME/yarn.lock
COPY package.json /$APP_NAME/package.json

COPY . /$APP_NAME/

RUN bin/rails assets:precompile assets:clean \
&& yarn install --production --frozen-lockfile \
&& yarn cache clean \
&& rm -rf /$APP_NAME/node_modules /$APP_NAME/tmp/cache

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
