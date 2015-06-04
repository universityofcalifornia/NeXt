class IdeasController < ApplicationController

  before_action only: [:show, :edit, :update, :delete] do
    @idea = Idea.includes(:idea_status).find(params[:id])
  end

  before_action only: [:edit, :update, :delete] do
    render nothing: true, status: :unauthorized unless @idea.is_editable_by? current_user
  end

  before_action only: [:new, :edit] do
    @idea_statuses = IdeaStatus.all
    @competencies = Competency.order(name: :asc)
  end

  def index
    @ideas = Idea.includes(:idea_status)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 50)
  end

  def new
    @idea = Idea.new
  end

  def create
    idea = Idea.create params[:idea].permit(:name, :pitch, :description, :idea_status_id)
    idea.idea_roles << IdeaRole.new(user: current_user, founder: true, admin: true)
    idea.competency_ids = params[:idea][:competencies]
    redirect_to idea_url(idea)
  end

  def show
  end

  def edit
  end

  def update
    @idea.update params[:idea].permit(:name, :pitch, :description, :idea_status_id)
    @idea.competency_ids = params[:idea][:competencies]
    redirect_to params[:return_to] ? params[:return_to] : idea_url(@idea)
  end

  def delete
    @idea.destroy
    redirect_to ideas_url
  end

end
