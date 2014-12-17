# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Load libraries the Rails application will leverage.
require 'application/context'
require 'application/error'
require 'rails/active_record/base'
require 'rails/active_record/connection_adapters/table_definition'
require 'ruby/hash/to_deep_ostruct'
require 'ruby/module/attr_html_reader'
require 'ruby/module/extend_method'

# Load settings from applicable YAML files in /config/environments (_default.yml and an environment-specific one if defined).
env_settings = YAML.load_file(Rails.root + 'config/environments/_default.yml')

if File.exists?(Rails.root + "config/environments/#{Rails.env}.yml")
  if env_specific_settings = YAML.load_file(Rails.root + "config/environments/#{Rails.env}.yml")
    env_settings.deep_merge! env_specific_settings
  end
end

Rails.application.configure do
  env_settings.each do |key, hash|
    config.send "#{key}=".to_sym, hash.to_deep_ostruct
  end
end
