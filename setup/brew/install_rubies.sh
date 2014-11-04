#!/bin/bash

rubies() {
  # TODO: this is where we'll map from debian package names to brew package names :)
  cat rubies.list
}

default_ruby() {
  cat rubies.list | head -1
}

for ruby in $(rubies); do
  rbenv install -s $ruby
done

rbenv global $(default_ruby)
rbenv rehash

gem update --system
gem install bundler --no-document
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
