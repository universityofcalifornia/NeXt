class ProjectNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, project
    @founder  = founder
    @participant = participant
    @project = project
    mail :to => @founder.email, :subject => "New participant in your project!"
  end
end