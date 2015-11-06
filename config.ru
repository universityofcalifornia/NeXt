# Load environment
require ::File.expand_path('../config/environment',  __FILE__)

# Test database connection
begin
  ActiveRecord::Base.connection.tables
rescue
  abort "ERROR: Could not connect to database"
end

# INITIALIZE ELASTICSEARCH
begin
  Rails.application.config.elasticsearch_client.ping
rescue => e
  abort "ERROR: Could not connect to Elasticsearch"
end

# RUN THE RAILS APPLICATION
run Rails.application
