class ActivitySummary < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def send_summary(user)
    # @invite = invite
    # @event = invite.event
    @user = user
    @project_votes = []
    user.project_roles.each do |project_roles|
      @project_votes << project_roles.project.project_votes
    end
    @project_votes.flatten!
    @project_votes.delete_if { |v| !v.created_at.between?(((Date.today - 7.days).beginning_of_day),(Date.today.end_of_day)) }

    @idea_votes = []
    user.idea_roles.each do |idea_roles|
      @idea_votes << idea_roles.idea.idea_votes
    end
    @idea_votes.flatten!
    @idea_votes.delete_if { |v| !v.created_at.between?(((Date.today - 7.days).beginning_of_day),(Date.today.end_of_day)) }


    mail(:to => "#{user.email}", :subject => "You weekly summary").deliver unless !WHITE_LIST_ARRAY.nil? and !WHITE_LIST_ARRAY.include? user.email
  end
end