class Competency < ActiveRecord::Base

  has_many :competency_users, dependent: :destroy, class: CompetencyUser
  has_many :users, through: :competency_users

  has_many :idea_competencies
  has_many :ideas, through: :idea_competencies, source: :idea

  has_many :project_competencies
  has_many :projects, through: :project_competencies, source: :project

end
