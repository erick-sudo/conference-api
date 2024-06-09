# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.2
FROM ruby:$RUBY_VERSION as base

# Set the working directory
WORKDIR /app

# Copy Gemfile
COPY Gemfile /app/Gemfile

# Install dependencies
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy the rest of the Rails application files to the container
COPY . .

# Copy the custom entrypoint script to the container
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Entrypoint prepares the database.
ENTRYPOINT ["entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "3000"]