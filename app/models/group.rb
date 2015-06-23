class Group < ActiveRecord::Base

  has_many :events, :through => :event_groups
  has_many :event_groups

  has_many :user, :through => :user_groups
  has_many :user_groups
end
