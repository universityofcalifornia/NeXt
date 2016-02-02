class Privacy < ActiveRecord::Base
  belongs_to :privacy_options, polymorphic: true
  belongs_to :organization
end
