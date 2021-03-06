module Auth
  module Local
    class RegistrationController < ApplicationController

      before_action do
        unless current_user and current_user.admin
          redirect_to new_auth_local_path
        end
      end

      before_action do
        unless Rails.application.config.respond_to?(:auth) && Rails.application.config.auth.respond_to?(:allow_local) && Rails.application.config.auth.allow_local
          raise Application::Error.new "Local accounts are not enabled. To enable them, auth.allow_local must be set to true."
        end
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new params[:user].permit(:email, :name_first, :name_last)
        if params[:user][:password] != params[:user][:password_confirmation]
          flash[:page_alert] = '<strong>Error.</strong> Password and confirmation did not match. Please try again.'
          flash[:page_alert_type] = 'danger'
          render :action => 'new'
        elsif !User.valid_password(params[:user][:password])
          logger.info "Invalid password"
          flash[:page_alert] = '<strong>Error.</strong> Password needs to be at least 8 characters long and contain at least one letter and one number'
          flash[:page_alert_type] = 'danger'
          render :action => 'new'
        elsif User.where(email: params[:user][:email]).count > 0
          flash[:page_alert] = '<strong>Error.</strong> Account already exists with the specified email address. Please try again.'
          flash[:page_alert_type] = 'danger'
          render :action => 'new'
        elsif !(params[:user][:email].ends_with?('ucla.edu') or
            params[:user][:email].ends_with?('berkeley.edu') or
            params[:user][:email].ends_with?('ucdavis.edu') or
            params[:user][:email].ends_with?('uci.edu') or
            params[:user][:email].ends_with?('ucmerced.edu') or
            params[:user][:email].ends_with?('ucr.edu') or
            params[:user][:email].ends_with?('ucsd.edu') or
            params[:user][:email].ends_with?('ucsf.edu') or
            params[:user][:email].ends_with?('ucsb.edu') or
            params[:user][:email].ends_with?('ucsc.edu') or
            params[:user][:email].ends_with?('ucop.edu') or
            params[:user][:email].ends_with?('lbl.gov') or
            params[:user][:email].ends_with?('llnl.gov') or
            params[:user][:email].ends_with?('lanl.gov') or
            params[:user][:email].ends_with?('ucanr.edu') or
            params[:user][:email].ends_with?('uchastings.edu') or
            params[:user][:email].ends_with?('cdlib.org'))
          flash[:page_alert] = '<strong>Error.</strong> Account email address must be a University email address. Please try again.'
          flash[:page_alert_type] = 'danger'
          render :action => 'new'
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
