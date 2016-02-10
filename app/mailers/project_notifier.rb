class ProjectNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, project
    unless founder.dont_receive_emails
      @founder  = founder
      @participant = participant
      @project = project
      mail :to => @founder.email, :subject => "New participant in your project!"
    end
  end

  def notify_new_founder new_founder
    unless new_founder.user.dont_receive_emails
      @email = new_founder.user.email
      @project = new_founder.project
      @name = new_founder.user.name_first
      mail :to => @email, :subject => "You are now the founder of a new project!"
    end
  end
end