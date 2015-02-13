# Be sure to restart your server when you modify this file.

require 'elasticsearch'

Rails.application.config.elasticsearch_client = Elasticsearch::Client.new

Rails.application.config.elasticsearch_config = {
  :index_name => 'next'
}
