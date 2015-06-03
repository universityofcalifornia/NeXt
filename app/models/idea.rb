require 'application/index_adapter/elasticsearch'
require 'application/index'

class Idea < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :idea_status

  has_many :idea_roles, dependent: :destroy
  has_many :idea_votes, dependent: :destroy

  has_many :project_ideas
  has_many :projects, through: :project_ideas, source: :project

  has_many :idea_competencies
  has_many :competencies, through: :idea_competencies, source: :competency

  has_many :comments, dependent: :destroy

  attr_html_reader :description

  def is_editable_by? user
    user and (idea_roles.where(user_id: user.id).count > 0 or user.super_admin)
  end

  def has_been_voted_for_by? user
    user and (idea_votes.where(user_id: user.id).count > 0)
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
        'competencies' => competencies.map(){ |c| c.name }
      })
    end
    body
  end

end
