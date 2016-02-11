class Invite < ActiveRecord::Base
  
  belongs_to :event

  scope :not_yet_invited, -> { where(:email_sent =>  false) }


  def self.email_recipients
    invites = not_yet_invited
    invites.each do |invite|
      EventNotifier.notify_invite(invite)
      invite.email_sent = true
      invite.save
    end
  end

end
