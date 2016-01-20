class Group < ActiveRecord::Base

  has_many :events, :through => :event_groups
  has_many :event_groups

  has_many :users, :through => :user_groups
  has_many :user_groups

  has_many :badge_groups, dependent: :destroy
  has_many :badges, through: :badge_groups, source: :badge

  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  
  scope :most_recent, -> { order(created_at: :desc) }

  attr_html_reader :description
  attr_html_reader :meetings

  def is_editable_by? user
    user and (user.id == user_id || user.super_admin)
  end
end
