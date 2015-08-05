module Auth
  module Local
    class RegistrationController < ApplicationController

      before_action do
        unless Rails.application.config.respond_to?(:auth) and Rails.application.config.auth.respond_to?(:allow_local) and Rails.application.config.auth.allow_local
          raise Application::Error.new "Local accounts are not enabled. To enable them, auth.allow_local must be set to true."
        end
      end

      def new
      end

      def create
        if !params[:user][:password] or params[:user][:password].length == 0 or params[:user][:password] != params[:user][:password_confirmation]
          flash[:page_alert] = '<strong>Error.</strong> Password and confirmation did not match. Please try again.'
          flash[:page_alert_type] = 'danger'
          redirect_to new_local_user_registration_url
        elsif User.where(email: params[:user][:email]).count > 0
          flash[:page_alert] = '<strong>Error.</strong> Account already exists with the specified email address. Please try again.'
          flash[:page_alert_type] = 'danger'
          redirect_to new_local_user_registration_url
        else
          @user = User.create(email: params[:user][:email],
                              name_first: params[:user][:name_first],
                              name_last: params[:user][:name_last],
                              password_hash: BCrypt::Password.create(params[:user][:password]))
          flash[:page_alert] = "<strong>Success.</strong> Local account has been created for <em>#{@user.email}</em>."
          flash[:page_alert_type] = 'success'
          redirect_to new_auth_local_path
        end

      end

    end
  end
end
