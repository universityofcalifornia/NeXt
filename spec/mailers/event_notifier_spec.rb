require "rails_helper"

describe EventNotifier, type: :mailer do
  describe 'instructions' do
    let(:invite) { mock_model(Invite, id: 1, email: 'email@email.com', :event => mock_model(Event, name: 'New Event', :user => mock_model(User, name: 'test', email: 'test@email.com') ) ) }
    let(:mail) { EventNotifier.notify_invite(invite) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Invitation to Event - New Event')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([invite.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['mailer@ucnext.org'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(invite.event.name)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to match("http://localhost:1234/invites/accept/1")
    end
  end
end
