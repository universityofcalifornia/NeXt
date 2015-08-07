require 'extend_method'

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include ApplicationHelper

  class << self
    include ExtendMethod
  end

  rescue_from Application::Error do |e|
    if e.properties.has_key? :redirect_to
      if e.properties[:redirect_to].is_a?(Array)
        send :redirect_to, *(e.properties[:redirect_to])
      else
        send :redirect_to, e.properties[:redirect_to]
      end
    else

    end
  end

  # if return_to is set, use this parameter instead of the usual redirect_to properties
  extend_method :redirect_to do |options = {}, response_status = {}|
    if params[:return_to]
      parent_method params[:return_to], response_status
    else
      parent_method options, response_status
    end
  end

  def current_user
    context.user
  end
  helper_method :current_user
end
