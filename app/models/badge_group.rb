class BadgeGroup < ActiveRecord::Base

  acts_as_paranoid

  has_many :badges, dependent: :destroy

end
