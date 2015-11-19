require 'application/index_adapter/elasticsearch'
require 'application/index'

class User < ActiveRecord::Base

  acts_as_paranoid

  has_many :oauth2_identities

  has_many :positions, dependent: :destroy
  has_many :organizations, through: :positions

  has_many :idea_roles, dependent: :destroy
  has_many :idea_votes, dependent: :destroy

  has_many :project_roles, dependent: :destroy
  has_many :project_votes, dependent: :destroy

  has_many :events

  has_many :groups, :through => :user_groups
  has_many :user_groups

  has_many :created_groups, :foreign_key => 'user_id', :class_name => 'Group'

  has_many :competency_users, dependent: :destroy
  has_many :competencies, through: :competency_users

  has_many :resource_users, dependent: :destroy
  has_many :resources, through: :resource_users

  has_many :comments, dependent: :destroy

  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  validates :name_last, :allow_nil => false, :presence => true
  validates :email, :allow_nil => false, :presence => true
  validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\Z/}

  belongs_to :primary_position, class: Position
  extend_method :primary_position do
    parent_method ? parent_method : positions.first
  end

  attr_html_reader :biography
  attr_html_reader :mailing_address, :nl

  attr_accessor :password,
                :password_confirmation

  scope :idea_founders, -> (idea) { includes(:idea_roles).where(idea_roles: { idea_id: idea, founder: true }) }
  scope :idea_admins, -> (idea) { includes(:idea_roles).where(idea_roles: { idea_id: idea, admin: true }) }
  scope :where_local, -> { where.not(:password_hash => nil) }

  def display_name format = :fl
    str = ''
    str << "#{name_first} " if format == :fml or format == :fl or format == :fmls
    str << "#{name_middle[0,1].capitalize}. " if (format == :fml or format == :fmls) and name_middle
    str << name_last
    str << ", #{name_suffix}" if format == :fmls
    str << ", #{name_first}" if format == :lfm or format == :lf
    str << " #{name_middle[0,1].capitalize}." if format == :lfm and name_middle
    str
  end

  def is_editable_by? user
    user and (user.id == id or user.super_admin)
  end

  def primary_organization
    primary_position ? primary_position.organization : nil
  end

  def is_local?
    !password_hash.nil?
  end

  def website_url
    website
  end

  def social_github_url
    "https://github.com/#{social_github}"
  end

  def social_google_url
    "https://plus.google.com/+#{social_google}"
  end

  def social_linkedin_url
    "https://www.linkedin.com/in/#{social_linkedin}"
  end

  def social_twitter_url
    "https://twitter.com/#{social_twitter}"
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
        type: 'users',
        id: id
    }
  end

  def index_body
    body = prepare_index_body do
      serializable_hash.merge({
        'competencies' => competencies.map(){ |c| c.name },
        'positions' => positions.map(){ |p| p.title }
      })
    end
    body
  end

  def give_badge badge
    badges << badge
    alter_points :other, badge.points
    Notifications.badge_received(badge, self).deliver
  end

  def alter_points(type, diff)
    case
    when type == :ideas
      self.idea_points    = [0, idea_points    + diff].max
    when type == :projects
      self.project_points = [0, project_points + diff].max
    else
      self.other_points   = [0, other_points   + diff].max
    end
    self.save

    if primary_organization
      case
      when type == :ideas
        primary_organization.idea_points    = [0, primary_organization.idea_points    + diff].max
      when type == :projects
        primary_organization.project_points = [0, primary_organization.project_points + diff].max
      else
        primary_organization.other_points   = [0, primary_organization.other_points   + diff].max
      end
      primary_organization.save
    end
  end

end
