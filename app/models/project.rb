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

  attr_html_reader :description

  def is_editable_by? user
    user and (project_roles.where(user_id: user.id).count > 0 or user.super_admin)
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
        'competencies' => competencies.map(){ |c| c.name }
      })
    end
    body
  end

end
