source "https://rubygems.org"

gem "rails", "~> 8.0.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "devise"
gem "devise-jwt"
gem "sidekiq"
gem "rspec-rails"
gem "kaminari"
gem "dotenv-rails"
gem "rack-cors"
gem "jsonapi-serializer"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "pry-nav"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "database_cleaner-active_record"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-tailwindcss", require: false
end
