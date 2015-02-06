class Project < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :project_status

  has_many :project_roles, dependent: :destroy
  has_many :users, through: :project_roles, source: :user

  has_many :project_ideas
  has_many :ideas, through: :project_ideas, source: :idea

  attr_html_reader :description

  def is_editable_by? user
    user and (project_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

end
