class Badge < ActiveRecord::Base

  belongs_to :badge_group

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

end
