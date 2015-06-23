class GroupsController < ApplicationController
  respond_to :json, :html

  def index
    @groups = Group.all
  end

  def ajax_index
    groups = Group.where("name like ?", "%#{params[:q]}%")
    user_groups = current_user.groups.map(&:id)
    new_groups = groups.reject{|n| user_groups.include?(n.id)}
    render json: new_groups.as_json(only: [:id, :name])
  end
end
