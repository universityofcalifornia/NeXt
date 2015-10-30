require 'application/index_adapter/elasticsearch'
require 'application/index'

class Project < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :project_status

  has_many :project_roles, dependent: :destroy
  has_many :users, through: :project_roles, source: :user

  has_many :project_ideas
  has_many :ideas, through: :project_ideas, source: :idea

  has_many :project_competencies
  has_many :competencies, through: :project_competencies, source: :competency

  has_many :project_resources
  has_many :resources, through: :project_resources, source: :resource

  has_many :project_votes, dependent: :destroy

  has_many :project_documents, dependent: :destroy

  attr_html_reader :description

  validates :name,
    presence: true, length: { maximum: 255 }

  validates :pitch,
    length: { maximum: 2000 }

  validates :website_url, :documentation_url, :source_url, :download_url,
    url: true, length: { maximum: 255 }

  scope :top_voted, -> (limit = nil) {
    joins("LEFT JOIN `project_votes` ON `project_votes`.`project_id` = `projects`.`id`")
      .select("`projects`.`id`, `projects`.`name`, COUNT(`project_votes`.`id`) AS `votes`")
      .group("`projects`.`id`")
      .order("votes DESC")
      .limit(limit)
  }

  def is_editable_by? user
    user and (project_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

  def is_votable_by? user
    user and !has_been_voted_for_by? user
  end

  def has_been_voted_for_by? user
    user and (project_votes.where(user_id: user.id).count > 0)
  end

  def voted_by user
    project_votes.find_by_user_id(user.id) || project_votes.new(:user => user)
  end

  # ELASTICSEARCH

  include Application::IndexAdapter::Elasticsearch
  include Application::Index

  after_save do
    destroy_index! if index_exists?
    create_index!
  end

  before_destroy do
    destroy_index!
  end

  def index_identity
    {
      index: index_name,
      type: 'projects',
      id: id
    }
  end

  def index_body
    body = prepare_index_body do
      serializable_hash.merge({
        'competencies' => competencies.map(){ |c| c.name },
        'votes' => project_votes.count
      })
    end
    body
  end

end
