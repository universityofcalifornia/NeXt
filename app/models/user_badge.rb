class UserBadge < ActiveRecord::Base

  belongs_to :user
  belongs_to :badge

  validates_uniqueness_of :user_id, :scope => :badge_id, :message => "already has this badge"

end
