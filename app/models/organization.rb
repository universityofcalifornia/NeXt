class Organization < ActiveRecord::Base

  has_many :positions
  has_many :users, through: :positions

end
