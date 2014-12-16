class Position < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user, touch: true
  belongs_to :organization

end
