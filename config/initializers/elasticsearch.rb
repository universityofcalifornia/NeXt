# Be sure to restart your server when you modify this file.

require 'elasticsearch'
require 'yaml'

# RELOAD_INDICES: set true to reset all indices (performance intense!)
RELOAD_INDICES = ENV["RELOAD_INDICES"]

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

# Create the index if it doesn't exist yet
unless Rails.application.config.elasticsearch_client.indices.exists index: config[:index_name]
  puts "Creating new elasticsearch index '#{config[:index_name]}'"
  Rails.application.config.elasticsearch_client.indices.create index: config[:index_name]
end

# RELOAD INDICES (if configured as such)
if RELOAD_INDICES
  [
    { name: 'idea', class: Idea, label: :name },
    { name: 'project', class: Project, label: :name },
    { name: 'user', class: User, label: :display_name }
  ].each do |o|
    o[:class].all.each do |obj|
      if obj.index_exists?
        puts "[#{o[:name]} - reset index - #{obj.id}] #{obj.send(o[:label])}"
        obj.destroy_index!
      end
      puts "[#{o[:name]} - create index - #{obj.id}] #{obj.send(o[:label])}"
      obj.create_index!
    end
  end
end
