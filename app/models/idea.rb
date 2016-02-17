require 'application/index_adapter/elasticsearch'
require 'application/index'

class Idea < ActiveRecord::Base

  attr_accessor :virtual_attribute

  acts_as_paranoid

  belongs_to :idea_status

  has_many :idea_roles, dependent: :destroy
  has_many :idea_votes, dependent: :destroy

  has_many :project_ideas
  has_many :projects, through: :project_ideas, source: :project

  has_many :idea_competencies
  has_many :competencies, through: :idea_competencies, source: :competency

  has_many :comments, as: :commentable

  has_one :privacy, as: :privacy_options

  validates :name, presence: true, length: { maximum: 255 }

  attr_html_reader :description

  scope :system_wide, -> { includes(:privacy).where(privacies: { id: nil }) }
  scope :visible_to_orgs, -> (organization_ids) { includes(:privacy).where(privacies: { organization_id: organization_ids.push(nil) }) }

  def is_editable_by? user
    user and (idea_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

  def is_votable_by? user
    user and !has_been_voted_for_by? user
  end

  def has_been_voted_for_by? user
    user and (idea_votes.where(user_id: user.id).count > 0)
  end

  def would_participate? user
    user and (idea_votes.where(user_id: user.id, participate: true).count > 0)
  end

  def voted_by user
    idea_votes.find_by_user_id(user.id) || idea_votes.new(:user => user)
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
        type: 'ideas',
        id: id
    }
  end

  def index_body
    body = prepare_index_body do
      serializable_hash.merge({
        'competencies' => competencies.map(){ |c| c.name },
        'votes' => idea_votes.count
      })
    end
    body
  end

  def is_owner? user
    if user.nil?
      return false
    else
      return user.idea_roles.where(founder: true, idea_id: id).count > 0
    end
  end

  def privacy_org
    return privacy.try(:organization)
  end

  def privacy_org= org_id
    org = Organization.find_by_id(org_id.to_i)
    if org
      self.privacy ||= Privacy.new
      self.privacy.organization = org
      self.privacy.save
    end
  end

  def global
    return privacy_org.nil?
  end

  def global= value
    if value == "true" && privacy
      self.privacy.organization = nil
      self.privacy.save
    end
  end

end
