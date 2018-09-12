FROM ruby:2.5.1 AS builder
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

FROM ruby:2.5.1-alpine
COPY --from=builder /app .
EXPOSE 3000
CMD rails s -b 0.0.0.0 -p 3000