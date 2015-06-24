class UserGroupsController < ApplicationController

  def create
    current_user.user_groups.where( :group_id => params[:id]).first_or_create
  end

  def destroy
    user_group = current_user.user_groups.where(:group_id => params[:group_id]).first
    user_group.destroy
  end
end
