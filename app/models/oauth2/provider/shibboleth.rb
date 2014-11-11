require 'oauth2/client'
require 'oauth2/provider_not_enabled'
require 'ostruct'

module OAuth2
  module Provider
    class Shibboleth

      def initialize access_token
        @access_token = access_token
      end

      def config
        self.class.config
      end

      def get_user
        data = JSON.parse(@access_token.get(config.routes[:get_user]).body)
        OpenStruct.new({
          id: data['eduPersonPrincipalName'],
          data: {
            name_first: data['givenName'],
            name_last: data['sn'],
            email: data['mail']
          },
          eduPersonScopedAffiliation: data.include?('eduPersonScopedAffiliation') ? data['eduPersonScopedAffiliation'].split(";").map(&:strip) : []
        })
      end

      class << self

        def config
          Rails.application.config.oauth2.provider.shibboleth
        end

        def client
          raise OAuth2::ProviderNotEnabled.new unless config.enabled
          OAuth2::Client.new config.key, config.secret, config.properties.marshal_dump
        end

        def access_token code, properties
          self.client.auth_code.get_token(code, properties)
        end

        def new_with_authorization code, properties
          self.new(self.access_token(code, properties))
        end

      end

    end
  end
end