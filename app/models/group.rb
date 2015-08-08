class Group < ActiveRecord::Base

  has_many :events, :through => :event_groups
  has_many :event_groups

  has_many :user, :through => :user_groups
  has_many :user_groups

  belongs_to :user

  scope :most_recent, -> { order(created_at: :desc) }

  def is_editable_by? user
    user and (user.id == user_id || user.super_admin)
  end
end
