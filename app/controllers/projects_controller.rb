class ProjectsController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy] do
    @project = Project.includes(:project_status).find(params[:id])
  end

  before_action only: [:edit, :update, :destroy] do
    render nothing: true, status: :unauthorized unless @project.is_editable_by? current_user
  end

  before_action only: [:new, :create, :edit, :update] do
    @ideas = Idea.order(name: :asc) # TODO: refine the list of this to only those pertinent to the user
    @project_statuses = ProjectStatus.all
    @competencies = Competency.order(name: :asc)
    @resources = Resource.all
  end

  def index
    @projects = Project.includes(:project_status)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 50)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new params[:project].permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url)

    if @project.save
      @project.project_roles << ProjectRole.new(user: current_user, founder: true, admin: true)
      @project.idea_ids       = params[:project][:ideas]
      @project.competency_ids = params[:project][:competencies]
      @project.resource_ids   = params[:project][:resources]

      redirect_to project_url(@project)

    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update params[:project].permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url)
      @project.idea_ids       = params[:project][:ideas]
      @project.competency_ids = params[:project][:competencies]
      @project.resource_ids   = params[:project][:resources]

      redirect_to params[:return_to] || project_url(@project)

    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end

end
