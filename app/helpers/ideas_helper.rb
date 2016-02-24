module IdeasHelper
  def link_to_idea idea
    if idea.is_viewable_by? current_user
      link_to idea.name, idea
    else
      content_tag :span, idea.name, :title => "This idea is campus-specific."
    end
  end
end
