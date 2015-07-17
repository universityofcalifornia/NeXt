class UsersController < ApplicationController

  before_action only: [:show, :edit, :update, :badges] do
    @user = User.find(params[:id])
  end

  before_action only: [:edit, :update] do
    unless @user.is_editable_by? current_user
      raise Application::Error.new "You do not have permission to edit the user (id: #{params[:id]})"
    end
  end

  def index
    @users = User.includes(:positions, :organizations)
                 .order(:name_last, :name_first)
                 .paginate(page: params[:page], per_page: 50)
  end

  def show
    unless current_user
      raise Application::Error.new "You must be logged in to view profiles",
                                   redirect_to: [
                                       auth_oauth2_launch_url(:shibboleth),
                                       flash: { return_to: user_url(@user) }
                                   ]
    end
    @founded_ideas = @user.idea_roles.where(founder: true).includes(:idea).take(5).map(){ |idea_role| idea_role.idea }
    @supported_ideas = @user.idea_votes.includes(:idea).take(5).map(){ |idea_vote| idea_vote.idea }
    @founded_projects = @user.project_roles.where('founder = 1 or admin = 1').includes(:project).take(5).map(){ |project_role| project_role.project }
    @involved_projects = @user.project_roles.where('founder = 0 and admin = 0').includes(:project).take(5).map(){ |project_role| project_role.project }
    @supported_projects = @user.project_votes.includes(:project).take(5).map(&:project)
    @showcased_badges = @user.user_badges.where(showcase: true).take(5).map(&:badge)
  end

  def edit
    @competencies = Competency.order(name: :asc).all
    @organizations = Organization.order(name: :asc).all
    @resources = Resource.all
  end

  def update

    permitted_params = [
        :email,
        :name_first,
        :name_middle,
        :name_last,
        :name_suffix,
        :website,
        :phone_number,
        :fax_number,
        :mailing_address,
        :biography,
        :social_google,
        :social_github,
        :social_linkedin,
        :social_twitter
    ]

    permitted_params << :super_admin if context.is_super_admin?

    @user.update params[:user].permit(permitted_params)
    @user.competency_ids = params[:user][:competencies]
    @user.resource_ids = params[:user][:resources]

    if params[:primary_position_organization_id]
      if params[:primary_position_organization_id] != '0'
        position = @user.primary_position ? @user.primary_position : Position.new(user_id: @user.id)
        position.organization_id = params[:primary_position_organization_id]
        position.title = params[:primary_position_title]
        position.department = params[:primary_position_department]
        position.description = params[:primary_position_description]
        position.save
      elsif @user.primary_position
        @user.primary_position.delete
      end
    end

    redirect_to user_url(@user)

  end

end
