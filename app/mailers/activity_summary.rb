class ActivitySummary < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def send_summary(user)
    # @invite = invite
    # @event = invite.event
    @user = user
    @project_votes = []
    user.project_roles.each do |project_roles|
      project_roles.project.project_votes.each do |project_vote|
        @project_votes << project_vote if project_vote.created_at.between?(((Date.today - 14.days).beginning_of_day),(Date.today.end_of_day))
      end
    end
    @project_votes.flatten!

    # @project_votes.delete_if { |v| v.project    }
    # @project_votes.delete_if { |v| !v.created_at.between?(((Date.today - 7.days).beginning_of_day),(Date.today.end_of_day)) }
    @projects = @project_votes.map { |p| p.project }.uniq
    

    # @projects.each do |x|
    #   x.project_votes
    # end

    @idea_votes = []
    user.idea_roles.each do |idea_roles|
      idea_roles.idea.idea_votes.each do |idea_vote|
        @idea_votes << idea_vote if idea_vote.created_at.between?(((Date.today - 14.days).beginning_of_day),(Date.today.end_of_day))
      end
    end
    @idea_votes.flatten!
    @ideas = @idea_votes.map { |i| i.idea }.uniq
    
    unless @ideas.empty? and @projects.empty?
      mail(:to => "#{user.email}", :subject => "You weekly summary").deliver unless !WHITE_LIST_ARRAY.nil? and !WHITE_LIST_ARRAY.include? user.email
    end
  end
end