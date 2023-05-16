FROM ruby:3.1

RUN apt-get update && apt-get install -y sudo less default-mysql-client

RUN mkdir /con-habit-app
WORKDIR /con-habit-app
COPY Gemfile /con-habit-app/Gemfile
COPY Gemfile.lock /con-habit-app/Gemfile.lock

# Bundlerの不具合対策(1)
RUN gem update --system
RUN bundle update --bundler

RUN bundle install
COPY . /con-habit-app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
