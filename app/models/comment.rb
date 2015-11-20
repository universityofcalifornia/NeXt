class Comment < ActiveRecord::Base
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  acts_as_nested_set polymorphic: true

  validates :body, :allow_nil => false, :presence => true

end
