class HomeController < ApplicationController
  def index
    require 'json'
    render plain: context.user.to_json
  end
end
