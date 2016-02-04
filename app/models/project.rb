require 'application/index_adapter/elasticsearch'
require 'application/index'

class Project < ActiveRecord::Base

  attr_accessor :virtual_attribute

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

  has_many :comments, as: :commentable

  has_one :privacy, as: :privacy_options

  attr_html_reader :description

  scope :system_wide, -> { includes(:privacy).where(privacies: { id: nil }) }
  scope :visible_to_orgs, -> (organization_ids) { includes(:privacy).where(privacies: { organization_id: organization_ids.push(nil) }) }

  validates :name,
    presence: true, length: { maximum: 255 }

  validates :pitch,
    length: { maximum: 2000 }

  validates :website_url, :documentation_url, :source_url, :download_url,
    url: true, length: { maximum: 255 }

  def is_editable_by? user
    user and (project_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

  def is_votable_by? user
    user and !has_been_voted_for_by? user
  end

  def has_been_voted_for_by? user
    user and (project_votes.where(user_id: user.id).count > 0)
  end

  def would_participate? user
    user and (project_votes.where(user_id: user.id, participate: true).count > 0)
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

  def is_owner? user
    if user.nil?
      return false
    else
      return user.project_roles.where(founder: true, project_id: id).count > 0
    end
  end

end
