class UserGroupsController < ApplicationController

  def create
    if UserGroup.where(group_id: params[:id], user_id: current_user.id).count == 0
      UserGroup.create(group_id: params[:id], user_id: current_user.id)
      current_user.alter_points :other, 1

      # If this group has any connected badges, give the user all of them (and their points)
      group = Group.find params[:id]
      if group
        group.badges.each do |badge|
          current_user.give_badge badge
        end
      end
    end

    redirect_to params[:return_to] if params[:return_to]
  end

  def destroy
    user_group = current_user.user_groups.where(:group_id => params[:group_id]).first
    user_group.destroy if user_group
    current_user.alter_points :other, -1

    redirect_to params[:return_to] if params[:return_to]
  end
end
