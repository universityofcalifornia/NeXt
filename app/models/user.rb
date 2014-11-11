class User < ActiveRecord::Base

  acts_as_paranoid

  has_many :oauth2_identities

  validates :name_last, :allow_nil => false, :presence => true
  validates :email, :allow_nil => false, :presence => true

end
