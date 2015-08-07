class Event < ActiveRecord::Base

	belongs_to :user

	has_many :invites #, :dependent => :destroy
	has_many :groups, :through => :event_groups
	has_many :event_groups

	validates :name, :presence => true

  domain_regex = URI::regexp(%w(http https))

	attr_accessor :invite_list, :group_tokens
	attr_accessor :end_date_time, :start_date_time

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

  def is_editable_by? user
    if user && (user.id == user_id || user.super_admin)
      return true
    else
      return false
    end
  end

	private
  def create_invites
    if @invite_list
      @invite_list.split(/,/).each do |email|
        self.invites.create(:email => email.strip)
      end
    end
  end

end
