class Oauth2Identity < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user

end
