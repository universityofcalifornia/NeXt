class User < ActiveRecord::Base

  acts_as_paranoid

  has_many :oauth2_identities

  has_many :positions, dependent: :destroy
  has_many :organizations, through: :positions

  validates :name_last, :allow_nil => false, :presence => true
  validates :email, :allow_nil => false, :presence => true

  belongs_to :primary_position, class: Position
  extend_method :primary_position do
    parent_method ? parent_method : positions.first
  end

  attr_html_reader :biography
  attr_html_reader :mailing_address, :nl

  def display_name format = :fl
    str = ''
    str << "#{name_first} " if format == :fml or format == :fl
    str << "#{name_middle[0,1].capitalize}. " if format == :fml and name_middle
    str << name_last
    str << ", #{name_first}" if format == :lfm or format == :lf
    str << " #{name_middle[0,1].capitalize}." if format == :lfm and name_middle
    str
  end

  def is_editable_by? user
    user.id == id or user.super_admin
  end

  def primary_organization
    primary_position ? primary_position.organization : nil
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

end
