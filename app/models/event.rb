class Event < ActiveRecord::Base

	belongs_to :user

	validates :name, :presence => true
	
  domain_regex = URI::regexp(%w(http https))

	validates :map_url, :format => { :with => domain_regex }, :if => "map_url.present?"
	
  validates :event_url, :format => { :with => domain_regex }, :if => "event_url.present?"
  
	mount_uploader :image, EventPromoPhotoUploader
end
