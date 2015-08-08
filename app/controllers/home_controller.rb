class HomeController < ApplicationController

  def index

    return welcome
    # TODO: differentiate between welcome and dashboard once we have a dashboard design
    # return current_user ? dashboard : welcome
  end

  def about

  end

  private

  def dashboard
    render 'dashboard'
  end

  def welcome
    render 'welcome'
  end

end
