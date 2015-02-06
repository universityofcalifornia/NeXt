class ProjectRole < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :project

  scope :founders, -> { where(founder: true) }
  scope :admins, -> { where(admin: true) }

end
