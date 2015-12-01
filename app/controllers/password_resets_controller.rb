class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: password_reset_params[:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
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

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

end