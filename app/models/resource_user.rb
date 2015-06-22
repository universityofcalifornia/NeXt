class ResourceUser < ActiveRecord::Base

  belongs_to :resource
  belongs_to :user

end
