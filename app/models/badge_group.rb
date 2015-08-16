class BadgeGroup < ActiveRecord::Base

  belongs_to :badge
  belongs_to :group

end
