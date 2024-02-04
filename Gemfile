# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.0'

gem 'action_policy'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'kredis'
gem 'pg'
gem 'puma', '>= 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.1.3'
gem 'redis', '>= 4.0.1'
gem 'sidekiq'
gem 'strong_migrations'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'database_consistency', group: :development, require: false
end

group :test do
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end
