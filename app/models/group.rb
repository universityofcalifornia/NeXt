class Group < ActiveRecord::Base

  has_many :events, :through => :event_groups
  has_many :event_groups
end
