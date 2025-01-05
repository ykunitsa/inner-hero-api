require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'devise/jwt/test_helpers'
require 'support/request_helpers'
require 'support/shoulda_matchers'
require 'support/database_cleaner'
require 'simplecov'
require 'simplecov-tailwindcss'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::TailwindFormatter

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include RequestHelpers, type: :request

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
end
