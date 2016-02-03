class IdeaNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, idea
    @founder  = founder
    @participant = participant
    @idea = idea
    mail :to => @founder.email, :subject => "New participant in your Idea!"
  end

  def notify_new_founder new_founder
    @email = new_founder.user.email
    @idea = new_founder.idea
    @name = new_founder.user.name_first
    mail :to => @email, :subject => "You are now the founder of a new idea!"
  end

end