class Position < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user, touch: true
  belongs_to :organization

  attr_html_reader :description, :nl

end
