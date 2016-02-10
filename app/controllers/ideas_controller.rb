class IdeasController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy] do
    @idea = Idea.includes(:idea_status).find(params[:id])

    unless @idea.is_viewable_by? current_user
      redirect_to :root
    end
  end

  before_action only: [:edit, :update, :destroy] do
    if current_user
      unless @idea.is_editable_by? current_user
        redirect_to :root
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:new, :edit] do
    @idea_statuses = IdeaStatus.all
    @competencies = Competency.order(name: :asc)
  end

  def index
    results = perform_search do |query|
      query.type 'ideas'
      query.limit 5
    end

    @top_ideas = results.map(&:model).sort_by { |idea| idea.idea_votes.count }.reverse!
    @organizations = Organization.all

    if current_user && current_user.super_admin
      idea_base = Idea
    elsif current_user
      idea_base = Idea.visible_to_orgs(current_user.organizations.map(&:id))
    else
      idea_base = Idea.system_wide
    end
    @ideas = idea_base.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new params[:idea].permit(:name, :pitch, :description, :idea_status_id)
    if @idea.save
      @idea.idea_roles << IdeaRole.new(user: current_user, founder: true)
      @idea.competency_ids = params[:idea][:competencies]
      @idea.refresh_index!
      current_user.alter_points :ideas, 3
      redirect_to idea_url(@idea)
    else
      @idea_statuses = IdeaStatus.all
      @competencies = Competency.order(name: :asc)
      render action: 'new'
      #redirect_to :back
    end
  end

  def show
    @comment = Comment.new(parent_id: params[:parent_id], commentable: @idea, return_to: idea_path(@idea))
    @comment_return_to = idea_path(@idea)
    @comments = Comment.where("commentable_id = ? and commentable_type = 'Idea' and depth = 0", @idea.id)
  end

  def edit
    @founder_email = @idea.idea_roles.where(founder: true).first.try(:user).try(:email)
  end

  def update

    if User.where(email: params[:idea][:idea_roles]).exists?

      unless @idea.idea_roles.where(founder: true).blank?
        previous_founder_email = @idea.idea_roles.where(founder: true).first.user.email
        @idea.idea_roles.where(founder: true).first.destroy
      end

      if params[:idea][:virtual_attribute].eql? ('1') and params[:idea][:idea_roles] != previous_founder_email
        idea_vote = @idea.idea_votes.where(user_id: User.where(email: previous_founder_email).first.id) unless previous_founder_email.nil?
        unless idea_vote.nil? or idea_vote[0].nil?
          idea_vote[0].delete
        end
      end
      @new_founder = IdeaRole.create(idea_id: @idea.id, user_id: User.where(email: params[:idea][:idea_roles]).first.id, founder: true)
      IdeaNotifier.notify_new_founder(@new_founder).deliver unless @idea.idea_roles.where(founder: true).first.user.email == previous_founder_email
    elsif !params[:idea][:idea_roles].blank?
      flash[:page_alert] = 'There is no UC Next user with the email you just entered. You can only transfer the idea to a UC Next user!'
      flash[:page_alert_type] = 'danger'
      @redirect_to_edit = true
    elsif params[:idea][:idea_roles].blank?
      flash[:page_alert] = 'All ideas now must have a founder! Please enter in an email for the transfer founder field.'
      flash[:page_alert_type] = 'danger'
      @redirect_to_edit = true
    end

    if @idea.update params[:idea].permit(:name, :pitch, :description, :idea_status_id)
      @idea.competency_ids = params[:idea][:competencies]
      @idea.refresh_index!

      if @redirect_to_edit
        redirect_to :back
      else
        redirect_to params[:return_to] ? params[:return_to] : idea_url(@idea)
      end
      
    else
      render action: 'edit'
    end

  end

  def destroy
    @idea.destroy
    current_user.alter_points :ideas, -3

    redirect_to ideas_url
  end

end
