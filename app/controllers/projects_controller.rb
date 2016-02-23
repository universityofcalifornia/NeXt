class ProjectsController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy] do
    @project = Project.includes(:project_status).find(params[:id])

    unless @project.is_viewable_by? current_user
      redirect_forbidden "This project is not public."
    end
  end

  before_action only: [:edit, :update, :destroy] do
    if current_user
      unless @project.is_editable_by? current_user
        redirect_forbidden "You cannot edit this project."
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
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

    @top_projects = results
      .map(&:model)
      .select { |project| project.is_viewable_by? current_user }
      .sort_by { |project| project.project_votes.count }
      .reverse!
    @organizations = Organization.all

    if current_user && current_user.super_admin
      project_base = Project
    elsif current_user
      project_base = Project.visible_to_orgs(current_user.organizations.map(&:id))
    else
      project_base = Project.system_wide
    end
    @projects = project_base.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params

    if @project.save
      @project.project_roles << ProjectRole.new(user: current_user, founder: true)
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
    @founder_email = @project.project_roles.where(founder: true).first.try(:user).try(:email)
  end

  def update

    if User.where(email: params[:project][:project_roles]).exists?

      unless @project.project_roles.where(founder: true).blank?
        previous_founder_email = @project.project_roles.where(founder: true).first.user.email
        @project.project_roles.where(founder: true).first.destroy
      end

      if params[:project][:virtual_attribute].eql? ('1') and params[:project][:project_roles] != previous_founder_email
        project_vote = @project.project_votes.where(user_id: User.where(email: previous_founder_email).first.id) unless previous_founder_email.nil?
        unless project_vote.nil? or project_vote[0].nil?
          project_vote[0].delete
        end
      end
      @new_founder = ProjectRole.create(project_id: @project.id, user_id: User.where(email: params[:project][:project_roles]).first.id, founder: true)
      ProjectNotifier.notify_new_founder(@new_founder).deliver unless @project.project_roles.where(founder: true).first.user.email == previous_founder_email
    elsif !params[:project][:project_roles].blank?
      flash[:page_alert] = 'There is no UC Next user with the email you just entered. You can only transfer the project to a UC Next user!'
      flash[:page_alert_type] = 'danger'
      @redirect_to_edit = true
    elsif params[:project][:project_roles].blank?
      flash[:page_alert] = 'All projects now must have a founder! Please enter the missing email address for the Transfer Founder field.'
      flash[:page_alert_type] = 'danger'
      @redirect_to_edit = true
    end

    if @project.update params[:project].permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url, :sponsor, :manager, :global)
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
    params.require(:project).permit(:name, :problem_statement, :pitch, :description, :project_status_id, :website_url, :documentation_url, :source_url, :download_url, :sponsor, :manager, :privacy_org)
  end


end
