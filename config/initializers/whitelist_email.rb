require 'yaml'

if Rails.env.staging?
  emails = YAML.load_file('config/whitelist_email.yml')
  WHITE_LIST_ARRAY = emails["whitelist_email"]
else
  WHITE_LIST_ARRAY = nil
end



