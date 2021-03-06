ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'simplecov'
# require_relative 'features/homepage_spec'
SimpleCov.start 'rails'

require 'coveralls'
Coveralls.wear!

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

SimpleCov.start("rails")
#Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# ActiveRecord::Base.logger = Logger.new(STDOUT)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  #config.include IntegrationSpecHelper, :type => :request
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    DatabaseCleaner.start
    # FactoryGirl.lint
  end

  config.after(:each) do
    DatabaseCleaner.clean
    $rspec_user_id = nil
  end

  #Capybara.default_host = 'localhost:3000'
#   OmniAuth.config.test_mode = true
#   OmniAuth.config.add_mock(:github, {
#   :uid => '12345',
#   :name => "Sam",
#   :nickname => "sts10",
#   :image_url => "http://cdn.bulbagarden.net/upload/thumb/e/e2/133Eevee.png/250px-133Eevee.png"
# })

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'default'
end
