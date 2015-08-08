class GroupsController < ApplicationController
  respond_to :json, :html

  before_action :find_group, only: [:show, :edit, :update, :destroy]

  before_action only: [:show, :edit, :update, :destroy] do
    @group = Group.find(params[:id])
  end

  before_action only: [:edit, :update, :destroy] do
    render nothing: true, status: :unauthorized unless @group.is_editable_by? current_user
  end

  def index
    @groups = Group.order(created_at: :desc)
                  .paginate(page: params[:page], per_page: 50)
  end

  def new
    @group = Group.new
  end

  def create
    group_data = group_params
    group_data[:user_id] = current_user.id
    @group = Group.create group_data
    current_user.groups << @group
    redirect_to group_url(@group)
  end

  def edit
  end

  def update
    @group.update!(group_params)
    redirect_to group_url(@group)
  end

  def show
  end

  def destroy
    @group.destroy
    redirect_to groups_url
  end

  # ajax methods

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

  private

  def find_group
    @group = Group.find_by(:id => params[:id])
  end

  def group_params
    params.required(:group).permit(:name, :user_id, :description, :contact_email, :listserv, :meetings, :membership_type)
  end

end
