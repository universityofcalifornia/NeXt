class UserGroupsController < ApplicationController

  def create
    UserGroup.where(:user_id => params[:user_id], :group_id => params[:id]).first_or_create
  end
end
