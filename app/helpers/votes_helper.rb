module VotesHelper
  def dynamic_vote_url object, vote_object
    if object.is_a? Project
      project_vote_url object, vote_object
    elsif object.is_a? Idea
      idea_vote_url object, vote_object
    else
      nil
    end
  end
end
