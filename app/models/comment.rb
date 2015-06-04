class Comment < ActiveRecord::Base
  
  acts_as_nested_set

  belongs_to :idea
  belongs_to :user

  validates :body, :allow_nil => false, :presence => true

end
