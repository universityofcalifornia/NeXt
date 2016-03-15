# Local login functionality is enabled by the existence of the auth hash and a value for the route key.
# 'allow_local' enables the admin local account management menu option.
# Shibboleth login via the OAuth2-Shib bridge is handled by the oauth2 hash.
#
# These are example settings that are designed to be overridden by a .gitignored file config/auth.yml. This pattern
# allows for any environment to override the auth properties without having multiple environment-specific config files
# or templates.
auth_settings = {
  :auth => { :route => '/auth/local/new', :allow_local => true },
  :oauth2 => {
    :provider => {
      :shibboleth => {
        :enabled => false,
        :key => 'The OAuth client key',
        :secret => 'The OAuth client secret',
        :properties => {
          :authorize_url => '/oauth2/authorize',
          :token_url => '/oauth2/access_token',
          :site => 'https://example.com'
        },
        :routes => {
          :get_user => '/oauth2/user'
        }
      }
    }
  }
}

if File.exists?('config/auth.yml')
  if overridden_auth_settings = YAML.load_file('config/auth.yml')
    auth_settings.deep_merge! overridden_auth_settings
  end
end

Rails.application.configure do
  auth_settings.each do |key, hash|
    config.send "#{key}=".to_sym, hash.to_deep_ostruct
  end
end

