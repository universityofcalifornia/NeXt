class IdeaStatus < ActiveRecord::Base

  acts_as_paranoid

  has_many :ideas

end
