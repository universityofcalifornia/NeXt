module Users
  class BadgesController < ApplicationController

    before_action do
      @user = User.find params[:user_id]
    end

    before_action only: [:index, :new] do
      @givable_badges = Badge.all.select { |badge| badge.is_givable_by?(current_user) && badge.is_givable_to?(@user) }
    end

    before_action only: [:update] do
      render nothing: true, status: :unauthorized unless @user.id == current_user.id
    end

    before_action only: [:update, :destroy] do
      @user_badge = @user.user_badges.find params[:id]
    end

    before_action only: [:create] do
      @badge = Badge.find params[:badge_id]
    end

    before_action only: [:destroy] do
      @badge = @user_badge.badge
    end

    before_action only: [:create, :destroy] do
      render nothing: true, status: :unauthorized unless @badge.is_givable_by? current_user
    end

    def index
      @user_badges = @user.user_badges
    end

    def new
    end

    def create
      @user.give_badge @badge

      redirect_to user_badges_url
    end

    def update
      @user_badge.showcase = params[:showcase]
      @user_badge.save

      redirect_to user_badges_url
    end

    def destroy
      @user_badge.destroy
      @user.alter_points :other, -@badge.points

      redirect_to user_badges_url
    end

  end
end
