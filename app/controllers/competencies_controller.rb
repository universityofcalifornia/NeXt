class CompetenciesController < ApplicationController

  before_action do
    if context.user
      unless context.user.super_admin
        raise Application::Error.new "You do not have permission to manage competencies. Please try searching by user instead."
      end
    else
      redirect_to new_session_path
    end
  end

  before_action only: [:show, :edit, :update, :destroy] do
    @competency = Competency.find(params[:id])
  end

  def index
    @competencies = Competency.order(name: :asc).all
  end

  def new
    @competency = Competency.new
  end

  def create
    @competency = Competency.create params[:competency].permit(:name)
    redirect_to competencies_url
  end

  def edit
  end

  def update
    @competency.update params[:competency].permit(:name)
    redirect_to competencies_url
  end

  def destroy
    @competency.destroy
    redirect_to competencies_url
  end

end