class IdeasController < ApplicationController

  before_action only: [:show, :edit, :update, :delete] do
    @idea = Idea.includes(:idea_status).find(params[:id])
  end

  def index
    @ideas = Idea.includes(:idea_status)
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 50)
  end

  def show
  end

end
