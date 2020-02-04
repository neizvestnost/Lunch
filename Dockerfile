FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /LunchOrdering
WORKDIR /LunchOrdering
COPY Gemfile /LunchOrdering/Gemfile
COPY Gemfile.lock /LunchOrdering/Gemfile.lock
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
RUN bundle install
