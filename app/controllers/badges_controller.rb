class BadgesController < ApplicationController

  before_action only: [:new, :create] do
    if current_user
      unless Badge.is_creatable_by? current_user
        redirect_to :root
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:show, :edit, :update, :destroy] do
    @badge = Badge.find(params[:id])
  end

  before_action only: [:edit, :update, :destroy] do
    if current_user
      unless @badge.is_editable_by? current_user
        redirect_to :root
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:show] do
    unless current_user
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:new, :edit] do
    @groups = Group.order(name: :asc)
  end

  def index
    @awards, @badges = Badge.all.partition { |badge| badge.is_a? Award }
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new params[:badge].permit(:name, :description, :image, :badge_category_id, :type, :website_url, :points)
    @badge.group_ids = params[:badge][:groups]

    if @badge.save
      @badge.badge_roles << BadgeRole.new(user: current_user, owner: true)
      @badge.badge_editor_ids = params[:badge][:badge_editor_ids]
      @badge.badge_giver_ids  = params[:badge][:badge_giver_ids]

      redirect_to badge_url(@badge)
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @badge.update params[:badge].permit(:name, :description, :image, :badge_category_id, :type, :website_url, :points)
      @badge.group_ids = params[:badge][:groups]
      @badge.badge_editor_ids = params[:badge][:badge_editor_ids] if @badge.is_owned_by? current_user
      @badge.badge_giver_ids  = params[:badge][:badge_giver_ids]

      redirect_to badge_url(@badge)
    else
      render action: 'edit'
    end
  end

  def destroy
    @badge.destroy
    redirect_to badges_url
  end

end
