# Umbrella-ella

This is a small Rails app that provides a JSON API and passes requests to the [OpenWeather Map API](http://openweathermap.org/api) — sort of a gateway. It's a demo app and it might not be the most useful one in the world, but that's okay!

[See it in action](https://umbrella-ella.herokuapp.com) or push this purple button:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Getting Started

First of all, make sure that Redis is installed and running on your machine. On OS X, use [Homebrew](http://brew.sh) to manage packages like Redis. Refer to its documentation for help with installing it.

This app uses Ruby 2.2.2, however 2.1 should work as well.

### Cloning

Clone this repo onto your machine, open a terminal, `cd` into the project directory and let Bundler install the gems:

```sh
bundle
```

Besides Redis, this app doesn't use a database like Postgres, so we don't need to create a database and load the database schema.

Figaro manages the environment variables. Create a custom configuration in `config/application.yml` and enter your API key. You can use the example configuration as a starting point:

```sh
cp config/application.sample.yml config/application.yaml
```

And that's it. Now, start the app by running `foreman start` from your terminal. Foreman will start WEBrick on port 5000 by default, so browse to [`localhost:5000`](http://localhost:5000) and you should see the app's intro page. Optionally use [Pow](http://pow.cx) as a proxy for something like `umbrellaella.dev`.

### Running the Tests

From the terminal, enter `rspec` to run the entire test suite or a specific test to be run, i.e. the model test by entering `rspec spec/models/weather_point_spec.rb`.

### Deployment

Probably the easiest and fastest way to deploy this app is with Heroku. Create a new app using their Dashboard or on the command line and push this repo. Make sure you've set the API key as an environment variable and added any Redis service as an addon. Or use the Deploy to Heroku button at the top of this README.

## Rationale

This app is a pet project. I created it as a kind of proof-of-concept to play with the OpenWeatherMap API and to streamline the steps necessary for deployment with Heroku.

Here's a bit of background information: I chose not to use any relational or NoSQL database because it simply isn't necessary. Data fetched from the API is cached in Redis using [Redis Persistence](https://github.com/socialinsider/redis-persistence). It is volatile and we don't need a more eternal data store like Postgres because we don't want to mirror the OpenWeatherMap API over time. We could use something like Redis' LRU cache eviction.

### Architecture

I created one simple model using ActiveModel. To fetch data from the API I'm using a service object which keeps the controller skinny and enables us to use it in a worker if necessary. You see, everything's quite simple.

## Trivia

What's with the name? Well, there's a song that goes by the name [Umbrella](http://www.vevo.com/watch/rihanna/umbrella-(orange-version)/USUV70702871). I'm not a huge fan but the that line was the first thing that came to my mind thinking of a Weather API. Weird, isn't it?