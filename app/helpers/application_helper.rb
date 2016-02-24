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

  def tooltip label, tooltip
    words = label.split
    last_word = words.pop

    content_tag(:span) do
      words.join(" ").concat(" ").html_safe +
      content_tag(:span, :class => "no-break") do
        last_word.concat(" ").html_safe +
        content_tag(
          :span,
          nil,
          :class => "glyphicon glyphicon-question-sign",
          :title => tooltip,
          :data  => { :toggle => "tooltip" }
        )
      end
    end
  end
end
