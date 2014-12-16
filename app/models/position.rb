class Position < ActiveRecord::Base

  belongs_to :position, touch: true
  belongs_to :organization

end
