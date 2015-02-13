# RELOAD_INDICES: set true to reset all Organization indices and then load in all Polls again (performance intense!)
RELOAD_INDICES = false

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

# RUN THE RAILS APPLICATION
run Rails.application