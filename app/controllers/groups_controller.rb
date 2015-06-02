class GroupsController < ApplicationController
  respond_to :json

  def index
    groups = Group.where("name like ?", "%#{params[:term]}%")
    render json: groups.as_json(only: [:name])
  end
end
