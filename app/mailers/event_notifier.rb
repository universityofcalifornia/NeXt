class EventNotifier < ActionMailer::Base
  default from: "from@example.com"

  def notify_invite(invite)
    Rails.logger.info "MAIL2: #{invite.email}"
    @invite = invite
    @event = invite.event
    mail(:to => "#{invite.email}", :subject => "Invitation to Event - #{@event.name}")
  end
end
