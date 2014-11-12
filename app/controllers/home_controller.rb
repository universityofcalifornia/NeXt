class HomeController < ApplicationController

  def index
    return context.user ? dashboard : welcome
  end

  private

  def dashboard
    render 'dashboard'
  end

  def welcome
    render 'welcome'
  end

end
