FROM ruby:3.2

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH
COPY Gemfile* $APP_PATH/
RUN bundle install
COPY . .
CMD ruby request_sender.rb
