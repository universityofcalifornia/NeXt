module Auth
  class Oauth2Controller < ApplicationController

    before_action do

      @provider_name = params[:id]
      require "oauth2/provider/#{@provider_name.underscore}"
      @provider_class = "OAuth2::Provider::#{@provider_name.camelize}".constantize

    end

    def launch

      flash.keep

      redirect_to @provider_class.client.auth_code.authorize_url(redirect_uri: auth_oauth2_return_url)

    end

    def return

      provider = @provider_class.new_with_authorization(params[:code], redirect_uri: auth_oauth2_return_url)

      provider_user = provider.get_user

      identity = Oauth2Identity.find_or_create_by provider: @provider_name,
                                                  provider_user_id: provider_user.id

      unless identity.user
        identity.user = User.create provider_user.data
        identity.save
      end

      context.user = identity.user

      redirect_to flash[:return_to] ? flash[:return_to] : root_path

    end

  end
end