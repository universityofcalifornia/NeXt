# Be sure to restart your server when you modify this file.

require 'elasticsearch'
require 'yaml'

config = {
    hosts: [
        { host: 'localhost', port: 9200 }
    ],
    index_name: 'next'
}

# Use the YAML file to override the host, port and index name
if File.exists?("config/elasticsearch.yml")
  config.merge!(YAML.load_file("config/elasticsearch.yml").deep_symbolize_keys)
end

Rails.application.config.elasticsearch_client = Elasticsearch::Client.new(config)

Rails.application.config.elasticsearch_config = {
   :index_name => config[:index_name]
}