class ProjectIdea < ActiveRecord::Base

  belongs_to :project
  belongs_to :idea

end
