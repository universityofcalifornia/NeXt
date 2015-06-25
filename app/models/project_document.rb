class ProjectDocument < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :project

  mount_uploader :filename, DocumentUploader

end
