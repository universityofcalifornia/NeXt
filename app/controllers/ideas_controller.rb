class IdeasController < ApplicationController

  before_action only: [:show, :edit, :update, :destroy] do
    @idea = Idea.includes(:idea_status).find(params[:id])
  end

  before_action only: [:edit, :update, :destroy] do
    unless @idea.is_editable_by? current_user
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

    @ideas = Idea.includes(:idea_status)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 15)
  end

  def new
    @idea = Idea.new

  end

  def create
    @idea = Idea.new params[:idea].permit(:name, :pitch, :description, :idea_status_id)
    if @idea.save
      @idea.idea_roles << IdeaRole.new(user: current_user, founder: true, admin: true)
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
  end

  def update
    @idea.update params[:idea].permit(:name, :pitch, :description, :idea_status_id)
    @idea.competency_ids = params[:idea][:competencies]
    @idea.refresh_index!
    redirect_to params[:return_to] ? params[:return_to] : idea_url(@idea)
  end

  def destroy
    @idea.destroy
    current_user.alter_points :ideas, -3

    redirect_to ideas_url
  end

end
