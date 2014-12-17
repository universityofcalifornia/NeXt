class Idea < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :idea_status

  attr_html_reader :pitch
  attr_html_reader :description

end
