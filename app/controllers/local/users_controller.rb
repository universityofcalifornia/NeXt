# NOTE: This controller is non-optimal and not intended for production use. It only exists
# for development purposes.

module Local
  class UsersController < ApplicationController

    before_action do
      unless Rails.application.config.respond_to?(:auth) and Rails.application.config.auth.respond_to?(:allow_local) and Rails.application.config.auth.allow_local
        raise Application::Error.new "Local accounts are not enabled. To enable them, auth.allow_local must be set to true."
      end
    end

    before_action do
      if context.user
        unless context.user.super_admin
          raise Application::Error.new "You do not have permission to manage other users."
        end
      else
        redirect_to new_session_path
      end
    end

    before_action only: [:edit, :update, :destroy] do
      @user = User.find(params[:id])
    end

    def index
      @users = User.where_local
                   .order(:name_last, :name_first)
                   .paginate(page: params[:page], per_page: 50)
    end

    def new
    end

    def create
      if !params[:user][:password] or params[:user][:password].length == 0 or params[:user][:password] != params[:user][:password_confirmation]
        flash[:page_alert] = '<strong>Error.</strong> Password and confirmation did not match. Please try again.'
        flash[:page_alert_type] = 'danger'
        redirect_to new_local_user_url
      elsif User.where(email: params[:user][:email]).count > 0
        flash[:page_alert] = '<strong>Error.</strong> Account already exists with the specified email address. Please try again.'
        flash[:page_alert_type] = 'danger'
        redirect_to new_local_user_url
      else
        @user = User.create(email: params[:user][:email],
                            name_first: params[:user][:name_first],
                            name_last: params[:user][:name_last],
                            super_admin: params[:user][:super_admin],
                            password_hash: BCrypt::Password.create(params[:user][:password]))
        flash[:page_alert] = "<strong>Success.</strong> Local account has been created for <em>#{@user.email}</em>."
        flash[:page_alert_type] = 'success'
        redirect_to local_users_url
      end
    end

    def edit
    end

    def update
      if params[:user][:password].length > 0 and params[:user][:password] == params[:user][:password_confirmation]
        @user.password_hash = BCrypt::Password.create(params[:user][:password])
        @user.save
        flash[:page_alert] = "<strong>Success.</strong> Password has been changed for <em>#{@user.email}</em>."
        flash[:page_alert_type] = 'success'
        redirect_to local_users_url
      else
        flash[:page_alert] = '<strong>Error.</strong> Password and confirmation did not match. Please try again.'
        flash[:page_alert_type] = 'danger'
        redirect_to edit_local_user_url(@user)
      end
    end

    def destroy
      flash[:page_alert] = "<strong>Success.</strong> Deleted the account for <em>#{@user.email}</em>."
      flash[:page_alert_type] = 'warning'
      @user.destroy
      redirect_to local_users_url
    end

  end
end