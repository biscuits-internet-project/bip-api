FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

COPY bin/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ADD . /app

# Expose port 3000 to the Docker host for external access
EXPOSE 3000

# Clean up stale pid files, prepend commands with bundle exec
ENTRYPOINT ["/docker-entrypoint.sh"]

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]