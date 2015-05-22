class Event < ActiveRecord::Base

	belongs_to :user

	has_many :invites #, :dependent => :destroy

	validates :name, :presence => true

  domain_regex = URI::regexp(%w(http https))

	attr_accessor :invite_list

	validates :map_url, :format => { :with => domain_regex }, :if => "map_url.present?"

  validates :event_url, :format => { :with => domain_regex }, :if => "event_url.present?"

	mount_uploader :image, EventPromoPhotoUploader

	after_create :create_invites

	def invite_list
		self.invites.pluck(:email).compact.join(', ')
	end

	private
  def create_invites
    if @invite_list
      self.invites = @invite_list.split(/,/).map do |email|
        Invite.where(:email => email.strip).first_or_create
      end

    end
  end
end
