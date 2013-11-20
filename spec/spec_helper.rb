# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Use Chrome!
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, switches: %w[--window-size=1024,1000 --ignore-certificate-errors --disable-popup-blocking --disable-translate])
end

Capybara.javascript_driver = :chrome

RSpec.configure do |config|
  config.include Capybara::DSL, :type => :controller

  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.order = "random"

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start

  end

  config.after do
    DatabaseCleaner.clean
  end
end
