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

	def start_date_time
		DateTime.parse(self.start_date + self.start_time).strftime("%B %d, %Y") if start_date && start_time
	end

	def end_date_time
		DateTime.parse(self.stop_date + self.stop_time).strftime("%B %d, %Y") if stop_date && stop_time
	end

	def start_date_time=(datetime)
		self.start_date = datetime.split(' ').first
		self.start_time = datetime.split(' ').last
	end

	def end_date_time=(datetime)
		self.stop_date = datetime.split(' ').first
		self.stop_time = datetime.split(' ').last
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
