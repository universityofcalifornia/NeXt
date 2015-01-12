class CompetencyUser < ActiveRecord::Base

  belongs_to :competency
  belongs_to :user

end
