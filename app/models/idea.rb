class Idea < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :idea_status

  has_many :idea_roles, dependent: :destroy
  has_many :idea_votes, dependent: :destroy

  has_many :project_ideas
  has_many :projects, through: :project_ideas, source: :project

  has_many :idea_competencies
  has_many :competencies, through: :idea_competencies, source: :competency

  attr_html_reader :description

  def is_editable_by? user
    user and (idea_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

  def has_been_voted_for_by? user
    user and (idea_votes.where(user_id: user.id).count > 0)
  end

end
