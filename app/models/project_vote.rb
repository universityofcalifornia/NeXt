class ProjectVote < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user
  belongs_to :project

  scope :participants,     -> { where(participate: true ) }
  scope :non_participants, -> { where(participate: false) }

end
