class GroupsController < ApplicationController
  respond_to :json, :html

  before_action :find_group, only: [:show, :edit, :update, :destroy]

  before_action only: [:show, :edit, :update, :destroy] do
    @group = Group.find(params[:id])
  end

  before_action only: [:show] do
    unless current_user
      require_login_status
      redirect_to :new_auth_local
    end
  end

  before_action only: [:edit, :update, :destroy] do
    if current_user
      unless @group.is_editable_by? current_user
        redirect_to :root
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
  end

  def index
    @groups = Group.order(created_at: :desc)
                  .paginate(page: params[:page], per_page: 9)
  end

  def new
    @group = Group.new
  end

  def create
    group_data = group_params
    group_data[:user_id] = current_user.id
    @group = Group.new group_data
    if @group.save
      current_user.groups << @group
      current_user.alter_points :other, 3
      redirect_to group_url(@group)
    else
      render action: 'new'
    end
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
    current_user.alter_points :other, -3

    redirect_to groups_url
  end

  # ajax methods

  def ajax_index
    groups = Group.where("name like ?", "%#{params[:q]}%")
    render json: groups.as_json(only: [:id, :name])
  end

  private

  def find_group
    @group = Group.find_by(:id => params[:id])
  end

  def group_params
    params.required(:group).permit(:name, :user_id, :description, :contact_email, :listserv, :meetings).merge(params.permit(:membership_type))
  end

end
