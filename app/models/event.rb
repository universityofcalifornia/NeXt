class Event < ActiveRecord::Base

	belongs_to :user

	validates :name, :presence => true
	
  domain_regex = /\A#{URI::regexp}\z/

	validates :map_url, :format => {  :with => domain_regex  }, if: Proc.new { |map_url| map_url.present? }
	
  validates :event_url, :format => {  :with => domain_regex  }, if: Proc.new { |event_url| event_url.present? }
  
	mount_uploader :image, EventPromoPhotoUploader
end
