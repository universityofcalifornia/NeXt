class ProjectCompetency < ActiveRecord::Base

  belongs_to :project
  belongs_to :competency

end
