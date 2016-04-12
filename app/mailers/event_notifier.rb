class EventNotifier < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def notify_invite(invite)
    user = User.where(email: invite.email).first
    if user
      unless user.dont_receive_emails
        @invite = invite
        @event = invite.event
        mail(:to => "#{invite.email}", :subject => "Invitation to Event - #{@event.name}").deliver unless !WHITE_LIST_ARRAY.nil? and !WHITE_LIST_ARRAY.include? invite.email
      end
    else
      @invite = invite
      @event = invite.event
      mail(:to => "#{invite.email}", :subject => "Invitation to Event - #{@event.name}").deliver unless !WHITE_LIST_ARRAY.nil? and !WHITE_LIST_ARRAY.include? invite.email
    end
  end
end
