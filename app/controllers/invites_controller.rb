class InvitesController < ApplicationController

  before_action :set_data

  def accept
    @invite.update(:status => true, :responded => true)
    flash[:notice] = "You have accepted and invite to #{@event.name}"
    redirect_to root_path
  end

  def decline
    @invite = Invite.where(:id => params[:id]).first
    event = Event.find(@invite.event_id)
    @invite.update(:status => false, :responded => true)
    flash[:notice] = "You declined the invitation to #{@event.name} "
    redirect_to root_path
  end

  private

  def set_data
    @invite = Invite.where(:id => params[:id]).first
    @event = @invite.event.name
  end

end
