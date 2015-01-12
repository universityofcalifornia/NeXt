class Competency < ActiveRecord::Base

  has_many :competency_users, dependent: :destroy, class: CompetencyUser
  has_many :users, through: :competency_users

end
