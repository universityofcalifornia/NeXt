class EventsController < ApplicationController

  respond_to :html

  #around_action :not_logged_in, :only => :index
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  before_action only: [:edit, :update, :destroy] do
    if current_user
      unless @event.is_editable_by? current_user
        redirect_to :root
      end
    else
      require_login_status
      redirect_to :new_auth_local
    end
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
    @event.update(event_params)
    respond_with @event
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
      unless @event
        redirect_to root_path, flash: {
          page_alert:      "The event you are looking for no longer exist",
          page_alert_type: 'danger'
        }
      end
    end

    def event_params
      params.required(:event).permit(:name, :short_description, :description, :image, :map_url, :event_url, :location, :invite_list, :group_tokens, :start_datetime, :stop_datetime)
    end
end
