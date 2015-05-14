class EventsController < ApplicationController

	respond_to :html

	before_action :find_event, only: [:show] 

	def index
		@events = Event.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
	end

	def logged_in
		@events = context.user.events.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
		render :index
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.create(event_params)
		respond_with @event
	end

	def show
		find_event
	end

	private

		def find_event
			@event = Event.find_by(:id => params[:id])
		end

		def event_params
      params.required(:event).permit(:name, :description)
    end
end