class EventsController < ApplicationController

  respond_to :html

  #around_action :not_logged_in, :only => :index
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  before_action only: [:edit, :update, :destroy] do
    render nothing: true, status: :unauthorized unless @event.is_editable_by? current_user
  end

  def index
    @events = Event.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
    @logged_in = false
  end

  def logged_in
    @events = current_user.events.order(created_at: :desc).paginate(page: params[:page], per_page: 50)
    @logged_in = true
    render :index
  end

  def new
    @event = Event.new
    @event.groups.build
  end

  def create
    @event = current_user.events.create(event_params)
    respond_with @event
  end

  def edit
  end

  def update
    @event.update!(event_params)
    redirect_to event_url(@event)
  end

  def show
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  private

    def not_logged_in
      unless current_user
        yield
      end
    end

    def find_event
      @event = Event.find_by(:id => params[:id])
    end

    def event_params
      params.required(:event).permit(:name, :short_description, :description, :image, :map_url, :event_url, :location, :invite_list, :group_tokens, :start_datetime, :stop_datetime)
    end
end
