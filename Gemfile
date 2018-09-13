source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.7.1'

# Use sqlite3 and mysql2 as database adapters for Active Record
gem 'sqlite3', '~> 1.3.10'
gem 'mysql2', '~> 0.3.17'

# Use elasticsearch as Elasticsearch client
gem 'elasticsearch', '~> 1.0.17'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', :group => :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', '~> 1.2.0', :group => :development

# Reimplements acts_as_paranoid
gem 'paranoia', '~> 2.0'

# Use oauth2 gem to support auth via OAuth 2
gem 'oauth2', '~> 1.0.0'

# Database-oriented session storage for larger session data
gem 'activerecord-session_store', '~> 0.1.2'

# GitHub-flavored markdown support
gem 'github-markup', '~> 1.4.0'
gem 'redcarpet', '~> 3.3.4'

# Pagination support
gem 'will_paginate', '~> 3.1.0'

# extend_method
gem 'extend_method', '~> 1.0.0'

# Because WebBlocks is so awful, we have to force these particular gem versions
gem 'compass', '1.0.1'
gem 'execjs', '2.2.2'

# Use web_blocks to compile Javascript assets
gem 'web_blocks', :git => 'https://github.com/WebBlocks/WebBlocks.git', :tag => '2.0.4.dev'

# Test coverage
gem 'coveralls', '0.8.13', :require => false

# Use either thin or puma for web server
gem 'thin', '~> 1.6.4'
gem 'puma', '~> 3.10.0'

gem 'bcrypt', '~>3.1.11', :require => 'bcrypt'
gem 'responders', '~> 2.0'

# Use awesome_nested_set for nested comments
gem 'awesome_nested_set', '~> 3.0.2'

gem "rmagick", '~> 2.15.4'
gem "carrierwave", '~>0.11.2'
gem 'foreigner', '~> 1.7.4'
gem "letter_opener", '~> 1.4.0', :group => :development
gem 'rufus-scheduler', '~> 3.2.1'
gem 'pry-rails', '~> 0.3.4', :group => :development

# generates a status page at /status.json
gem 'rapporteur', '~> 3.4.0'

# convert UTC to user's local time
gem 'local_time', '~> 1.0.3'

group :development, :test do
  gem 'rspec-rails', '~> 3.8.0'
  gem 'capybara', '~> 2.4.4'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'launchy', '~> 2.4.3'
  gem 'rspec-activemodel-mocks', '~> 1.0.1'
end

group :test do
  gem 'email_spec', '~> 1.6.0'
end

# Really useful gem for debugging
group :development do
  gem 'awesome_print', '~> 1.6.1'
end

gem 'simplecov', '~> 0.11.2', :require => false, :group => :test
