module Auth
  class LocalController < ApplicationController

    before_action do
      unless Rails.application.config.respond_to?(:auth) and Rails.application.config.auth.respond_to?(:allow_local) and Rails.application.config.auth.allow_local
        raise Application::Error.new "Local accounts are not enabled. To enable them, auth.allow_local must be set to true."
      end
    end

    def new
    end

    def create
      if user = User.find_by_email(params[:session][:email])
        if BCrypt::Password.new(user.password_hash).is_password? params[:session][:password]
          context.user = user
          return redirect_to flash[:return_to] ? flash[:return_to] : root_path
        end
      end
      flash[:page_alert] = '<strong>Login failed.</strong> Username or password did not match. Please try again.'
      flash[:page_alert_type] = 'danger'
      redirect_to new_auth_local_path
    end

  end
end