class ProjectStatus < ActiveRecord::Base

  acts_as_paranoid

  has_many :projects

end
