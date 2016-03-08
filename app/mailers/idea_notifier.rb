class IdeaNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_founder founder, participant, idea
    unless founder.dont_receive_emails
      @founder  = founder
      @participant = participant
      @idea = idea
      mail(:to => @founder.email, :subject => "New participant in your Idea!").deliver unless Rails.env.staging? and !WHITE_LIST_ARRAY.include? invite.email
    end
  end

  def notify_new_founder new_founder
    unless new_founder.user.dont_receive_emails
      @email = new_founder.user.email
      @idea = new_founder.idea
      @name = new_founder.user.name_first
      mail(:to => @email, :subject => "You are now the founder of a new idea!").deliver unless Rails.env.staging? and !WHITE_LIST_ARRAY.include? invite.email
    end
  end

end