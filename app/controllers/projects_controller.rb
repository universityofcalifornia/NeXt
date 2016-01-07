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
  end

  def edit
    @founder_email = @project.project_roles.where(admin: true).first.user.email
  end

  def update

    if User.where(email: params[:project][:project_roles]).exists?
      @project.project_roles.where(founder: true).first.destroy
      ProjectRole.create(project_id: @project.id, user_id: User.where(email: params[:project][:project_roles]).first.id, admin: true, founder: true)
    elsif !params[:project][:project_roles].blank?
      flash[:page_alert] = 'There is no UC Next user with the email you just entered. You can only transfer the project to a UC Next user!'
      flash[:page_alert_type] = 'danger'
      @redirect_to_edit = true
    end

    if @project.update params[:project].permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url, :sponsor, :manager)
      @project.idea_ids       = params[:project][:ideas]
      @project.competency_ids = params[:project][:competencies]
      @project.resource_ids   = params[:project][:resources]
      @project.refresh_index!

      if @redirect_to_edit
        redirect_to :back
      else
        redirect_to params[:return_to] || project_url(@project)
      end

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
