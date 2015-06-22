class ResourcesController < ApplicationController

  before_action except: [:show] do
    if current_user
      unless current_user.super_admin
        raise Application::Error.new "You do not have permission to manage resources. Please try searching by user instead."
      end
    else
      redirect_to new_session_path
    end
  end

  before_action only: [:show, :edit, :update, :destroy] do
    @resource = Resource.find(params[:id])
  end

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.create params[:resource].permit(:name)
    redirect_to resources_url
  end

  def edit
  end

  def update
    @resource.update params[:resource].permit(:name)
    redirect_to resources_url
  end

  def destroy
    @resource.destroy
    redirect_to resources_url
  end

end