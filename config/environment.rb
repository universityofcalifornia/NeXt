# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load libraries the Rails application will leverage.
require 'application/context'
require 'application/error'
require 'rails/active_record/base'
require 'rails/active_record/connection_adapters/table_definition'
require 'ruby/hash/to_deep_ostruct'
require 'ruby/module/attr_html_reader'
require 'ruby/module/extend_method'
require 'ruby/string/ellipsis'

# Initialize the Rails application.
Rails.application.initialize!
