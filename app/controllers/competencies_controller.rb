class CompetenciesController < ApplicationController

  respond_to :json, :html

  before_action except: [:show,:ajax_index] do
    if current_user
      unless current_user.super_admin
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
    @competencies = Competency.all
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

  # ajax methods

  def ajax_index
    competencies = Competency.where("name like ?", "%#{params[:q]}%")
    user_competencies = current_user.competencies.map(&:id)
    new_competencies = competencies.reject{|n| user_competencies.include?(n.id)}
    render json: new_competencies.as_json(only: [:id, :name])
  end

end