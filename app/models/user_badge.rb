class UserBadge < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :badge

end
