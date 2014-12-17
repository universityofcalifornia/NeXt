class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include ApplicationHelper

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

end
