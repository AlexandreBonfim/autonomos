# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails' # Rails is fully loaded from here on

# Auto-require files in spec/support (helpers, shared contexts, etc.)
Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Keep test DB schema in sync
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Fixtures (optional)
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Helpers
  config.include FactoryBot::Syntax::Methods
  config.include ActiveJob::TestHelper

  # DatabaseCleaner (transactional, with truncation before suite)
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  # ActiveJob test adapter & queues reset per example
  config.before(:each) do
    ActiveJob::Base.queue_adapter = :test
    clear_enqueued_jobs
    clear_performed_jobs
  end

  # Filter Rails noise from backtraces
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem_name")
end
