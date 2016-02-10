module UsersHelper
  def link_to_user user
    if current_user && user.is_viewable_by?(current_user)
      link_to user.display_name, user
    else
      content_tag :span, user.display_name, :title => "This user's profile is hidden."
    end
  end
end
