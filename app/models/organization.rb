class Organization < ActiveRecord::Base

  acts_as_paranoid

  has_many :positions
  has_many :users, through: :positions

end
