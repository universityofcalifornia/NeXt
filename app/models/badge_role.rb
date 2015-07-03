class BadgeRole < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :badge

  scope :owners,  -> { where(owner:  true) }
  scope :editors, -> { where(editor: true) }
  scope :givers,  -> { where(giver:  true) }

end
