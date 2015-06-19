class Resource < ActiveRecord::Base

  has_many :resource_users, dependent: :destroy
  has_many :users, -> { order(:name_last, :name_first) }, through: :resource_users

  has_many :project_resources
  has_many :projects, -> { order(:name) }, through: :project_resources, source: :project

  default_scope { order(:name) }

end
