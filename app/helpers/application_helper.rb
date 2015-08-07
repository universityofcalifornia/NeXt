require 'application/context'

module ApplicationHelper

  def context

    unless @context
      @context = ::Application::Context.new controller: self
      @context.load_from_session!
    end

    @context

  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
end
