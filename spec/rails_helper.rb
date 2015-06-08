# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'capybara/rspec'
require 'capybara/rails'
require 'webrick/https'
require 'rack/handler/webrick'
require "email_spec"

p "START"
 Capybara.server_port = 3000
 Capybara.run_server = false
 Capybara.app_host = "http://localhost:%d" % Capybara.server_port
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  profile.secure_ssl = false
  profile.assume_untrusted_certificate_issuer = false
  Capybara::Selenium::Driver.new(app, :browser => :chrome, profile: profile)
end
Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new(app).tap {|d| d.browser.ignore_ssl_errors }
end
p "END"
puts "Running with Capybara.current_driver: "
puts Capybara.app_host
Capybara.server do |app, port|
  p "SERVER!!!"
  run_ssl_server(app, port)
end
# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryGirl::Syntax::Methods
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end



def run_ssl_server(app, port)

  opts = {
    :Port => port,
    :SSLEnable => true,
    :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
    :SSLPrivateKey => OpenSSL::PKey::RSA.new(File.read "./spec/support/server.key"),
    :SSLCertificate => OpenSSL::X509::Certificate.new(File.read "./spec/support/server.crt"),
    :SSLCertName => [["US", 'localhost']],
    :AccessLog => [],
    :Logger => WEBrick::Log::new(Rails.root.join("./log/capybara_test.log").to_s)
  }

  Rack::Handler::WEBrick.run(app, opts)
end
