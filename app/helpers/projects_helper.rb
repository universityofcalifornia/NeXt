module ProjectsHelper
  def link_to_project project
    if project.is_viewable_by? current_user
      link_to project.name, project
    else
      content_tag :span, project.name, :title => "This project is campus-specific."
    end
  end
end
