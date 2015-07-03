class Badge < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :badge_group

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_many :badge_roles, dependent: :destroy
  has_many :users, through: :badge_roles, source: :user

end
