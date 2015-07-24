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

  def ajax_create
    if params[:group_name].present?
      new_group = current_user.created_groups.where(:name => params[:group_name]).first_or_create
      current_user.groups << new_group if params[:checked]
    end
  end
end
