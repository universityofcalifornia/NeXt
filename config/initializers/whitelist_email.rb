require 'yaml'

if Rails.env.staging?
  emails = YAML.load_file('config/whitelist_email.yml')
  WHITE_LIST_ARRAY = emails["whitelist_email"]
end



