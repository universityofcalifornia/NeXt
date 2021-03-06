class IdeaRole < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :idea

  scope :founders, -> { where(founder: true) }

end
