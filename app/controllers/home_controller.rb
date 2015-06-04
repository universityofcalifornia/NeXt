class HomeController < ApplicationController

  def index
    return current_user ? dashboard : welcome
  end

  private

  def dashboard
    render 'dashboard'
  end

  def welcome
    render 'welcome'
  end

end
