FROM ruby:2.3.1

ENV app /gravatar

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir $app
WORKDIR $app
RUN gem install bundler
ENV BUNDLE_PATH /bundle

WORKDIR $app
COPY . ./

# FROM ruby:2.3.1
#
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         build-essential libpq-dev nodejs \
#         postgresql postgresql-contrib redis-server \
#     && rm -rf /var/lib/apt/lists/*
# RUN sleep 3
# WORKDIR /usr/src/app
# COPY . ./
# RUN bundle install
# RUN bundle exec rake db:create
# RUN bundle exec rake db:migrate
#
# EXPOSE 3000
# CMD ["rails", "server", "-b", "0.0.0.0"]
