class UsersController < ApplicationController

  before_action only: [:show, :edit, :update] do
    @user = User.find(params[:id])
  end

  before_action only: [:edit, :update] do
    unless @user.is_editable_by? context.user
      raise Application::Error.new "You do not have permission to edit the user (id: #{params[:id]})"
    end
  end

  def index
    @users = User.includes(:positions, :organizations)
                 .order(:name_last, :name_first)
                 .paginate(page: params[:page], per_page: 50)
  end

  def show
    unless context.user
      raise Application::Error.new "You must be logged in to view profiles",
                                   redirect_to: [
                                       auth_oauth2_launch_url(:shibboleth),
                                       flash: { return_to: user_url(@user) }
                                   ]
    end
  end

  def edit
  end

  def update
  end

end
