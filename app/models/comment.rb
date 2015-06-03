class Comment < ActiveRecord::Base
  
  acts_as_nested_set

  belongs_to :idea
  belongs_to :user

end
