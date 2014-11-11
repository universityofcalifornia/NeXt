require 'application/context'

module ApplicationHelper

  def context

    unless @context
      @context = ::Application::Context.new controller: self
      @context.load_from_session!
    end

    @context

  end

end
