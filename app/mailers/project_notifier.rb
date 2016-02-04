class ProjectNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, project
    @founder  = founder
    @participant = participant
    @project = project
    mail :to => @founder.email, :subject => "New participant in your project!"
  end

  def notify_new_founder new_founder
    @email = new_founder.user.email
    @project = new_founder.project
    @name = new_founder.user.name_first
    mail :to => @email, :subject => "You are now the founder of a new project!"
  end
end