# This could be factored out into a more general action_mailer.rb config.

require 'yaml'

config = {
  # SMTP-specific properties
  smtp_host: 'localhost',
  smtp_port: 587,
  smtp_username: 'username',
  smtp_password: 'changeme',
  smtp_authentication: 'plain',
  smtp_enable_starttls_auto: true
}

# Use the YAML file to override the SMTP settings
if File.exists?('config/smtp.yml')
  config.merge!(YAML.load_file('config/smtp.yml').deep_symbolize_keys)
end

# Only enable SMTP for production. The staging server is setup to use the
# production environment as well.
if Rails.env.production?
  Rails.application.config.action_mailer.smtp_settings = {
      :address              => config[:smtp_host],
      :port                 => config[:smtp_port],
      :user_name            => config[:smtp_username],
      :password             => config[:smtp_password],
      :authentication       => config[:smtp_authentication],
      :enable_starttls_auto => config[:smtp_enable_starttls_auto]
  }
end