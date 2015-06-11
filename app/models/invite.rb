class Invite < ActiveRecord::Base
  belongs_to :event

  scope :all_that_have_not_responded, -> { where(:responded =>  false) }


  def self.email_recipients
    invites = all_that_have_not_responded
    invites.each do |invite|
      EventNotifier.notify_invite(invite)
    end
  end
end
