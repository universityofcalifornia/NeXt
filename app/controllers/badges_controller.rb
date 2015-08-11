class BadgesController < ApplicationController

  before_action only: [:new, :create] do
    unless Badge.is_creatable_by? current_user
      raise Application::Error.new "You do not have permission to create badges/awards."
    end
  end

  before_action only: [:show, :edit, :update, :destroy] do
    @badge = Badge.find(params[:id])
  end

  before_action only: [:edit, :update, :destroy] do
    unless @badge.is_editable_by? current_user
      raise Application::Error.new "You do not have permission to edit this badge/award."
    end
  end

  def index
    @badges = Badge.all
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new params[:badge].permit(:name, :description, :image, :badge_group_id, :type, :website_url, :points)

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
    if @badge.update params[:badge].permit(:name, :description, :image, :badge_group_id, :type, :website_url, :points)
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
