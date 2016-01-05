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
    results = perform_search do |query|
      query.type 'projects'
      query.limit 5
    end

    @top_projects = results.map(&:model).sort_by { |project| project.project_votes.count }.reverse!

    @projects = Project.includes(:project_status)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 15)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params

    if @project.save
      @project.project_roles << ProjectRole.new(user: current_user, founder: true, admin: true)
      @project.idea_ids       = params[:project][:ideas]
      @project.competency_ids = params[:project][:competencies]
      @project.resource_ids   = params[:project][:resources]
      @project.refresh_index!

      current_user.alter_points :projects, 5

      redirect_to project_url(@project)

    else
      render action: 'new'
    end
  end

  def show
    @comment = Comment.new(parent_id: params[:parent_id], commentable: @project, return_to: project_path(@project))
    @comment_return_to = project_path(@project)
    @comments = Comment.where("commentable_id = ? and commentable_type = 'Project' and depth = 0", @project.id)
  end

  def edit
  end

  def update
    if @project.update params[:project].permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url, :sponsor, :manager)
      @project.idea_ids       = params[:project][:ideas]
      @project.competency_ids = params[:project][:competencies]
      @project.resource_ids   = params[:project][:resources]
      @project.refresh_index!

      redirect_to params[:return_to] || project_url(@project)

    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    current_user.alter_points :projects, -5

    redirect_to projects_url
  end

  private

  def project_params
    params.require(:project).permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url, :sponsor, :manager)
  end


end
