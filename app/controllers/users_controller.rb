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
    @founded_ideas = @user.idea_roles.where(founder: true).includes(:idea).take(5).map(){ |idea_role| idea_role.idea }
    @supported_ideas = @user.idea_votes.includes(:idea).take(5).map(){ |idea_vote| idea_vote.idea }
    @founded_projects = @user.project_roles.where('founder = 1 or admin = 1').includes(:project).take(5).map(){ |project_role| project_role.project }
    @supported_projects = @user.project_roles.where('founder = 0 and admin = 0').includes(:project).take(5).map(){ |project_role| project_role.project }
  end

  def edit
    @competencies = Competency.order(name: :asc).all
  end

  def update
    @user.update params[:user].permit(:email,
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
                                      :social_twitter)
    @user.competency_ids = params[:user][:competencies]
    redirect_to user_url(@user)
  end

end
