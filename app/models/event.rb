class Event < ActiveRecord::Base

	belongs_to :user

	has_many :invites #, :dependent => :destroy
	has_many :groups, :through => :event_groups
	has_many :event_groups

	validates :name, :presence => true

  domain_regex = URI::regexp(%w(http https))

	attr_accessor :invite_list
	attr_accessor :group_tokens

	validates :map_url, :format => { :with => domain_regex }, :if => "map_url.present?"

  validates :event_url, :format => { :with => domain_regex }, :if => "event_url.present?"

	mount_uploader :image, EventPromoPhotoUploader

	after_create :create_invites

	def invite_list
		self.invites.pluck(:email).compact.join(', ')
	end

	def group_tokens=(ids)
    self.group_ids = ids.split(",")
  end

	private
  def create_invites
    if @invite_list
      self.invites = @invite_list.split(/,/).map do |email|
        Invite.where(:email => email.strip).first_or_create
      end
			notify_invites
    end
  end

	def notify_invites
		self.invites.each do |invite|
			EventNotifier.notify_invites(invite).deliver
		end
	end
end
