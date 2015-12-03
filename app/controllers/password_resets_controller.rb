class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :authenticated_user,   only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]




  def new
  end

  def create
    @user = User.find_by(email: password_reset_params[:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      # redirect_to edit_password_reset_url(@user.reset_token, email: @user.email)

      flash[:page_alert] = "Email sent with password reset instructions"
      flash[:page_alert_type] = "success"
      redirect_to root_url
    else
      flash[:page_alert] = "<strong>Error.</strong> Email address not found"
      flash[:page_alert_type] = "danger"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:page_alert] = '<strong>Error.</strong> Password and confirmation did not match. Please try again.'
      flash[:page_alert_type] = 'danger'
      render 'edit'
    elsif !User.valid_password(params[:user][:password])
      flash[:page_alert] = '<strong>Error.</strong> Password needs to be at least 8 characters long and contain at least one letter and one number'
      flash[:page_alert_type] = 'danger'
      render 'edit'
    elsif @user.update_attributes(password_hash: BCrypt::Password.create(user_params[:password]))
      flash[:page_alert] = "Password has been reset"
      flash[:page_alert_type] = "success"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def authenticated_user
    redirect_to root_url unless BCrypt::Password.new(@user.reset_digest).is_password?(params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end

end