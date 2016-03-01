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
    @event = current_user.events.new(event_params)
    if valid_email? event_params[:invite_list]
      @event.save
      respond_with @event
    else
      flash[:page_alert] = 'Please enter valid emails separated by commas in the invite list!'
      flash[:page_alert_type] = 'danger'
      render :action=>'new'
    end
  end

  def edit
  end

  def update
    if valid_email? event_params[:invite_list]
      @event.update(event_params)
      respond_with @event
    else
      flash[:page_alert] = 'Please enter valid emails separated by commas in the invite list!'
      flash[:page_alert_type] = 'danger'
      render :action=>'edit'
    end
  end

  def show
  end

  def destroy
    @event.destroy
    redirect_to events_url
  end

  private

    def valid_email? email_list
      @checking_array = email_list.split(/,/).uniq.collect{|x| x.strip || x }
      valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      @checking_array.each do |x|
        if (x =~ valid_email_regex).nil?
          return false
        end
      end
      true
    end

    def not_logged_in
      unless current_user
        yield
      end
    end

    def find_event
      @event = Event.find_by(:id => params[:id])
      unless @event
        redirect_to root_path, flash: {
          page_alert:      "The event does not exist.",
          page_alert_type: 'danger'
        }
      end
    end

    def event_params
      params.required(:event).permit(:name, :short_description, :description, :image, :map_url, :event_url, :location, :invite_list, :group_tokens, :start_datetime, :stop_datetime)
    end
end
