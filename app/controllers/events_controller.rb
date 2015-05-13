class EventsController < ApplicationController

	def index
		@events = Event.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
	end

end