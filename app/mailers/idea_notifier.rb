class IdeaNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, idea
    @founder  = founder
    @participant = participant
    @idea = idea
    mail :to => @founder.email, :subject => "New participant in your Idea!"
  end
end