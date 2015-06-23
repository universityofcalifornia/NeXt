class GroupsController < ApplicationController
  respond_to :json, :html

  def index
    @groups = Group.all
  end

  def ajax_index
    groups = Group.where("name like ?", "%#{params[:q]}%")
    render json: groups.as_json(only: [:id, :name])
  end
end
