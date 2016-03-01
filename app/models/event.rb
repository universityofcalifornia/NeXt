class Event < ActiveRecord::Base

  belongs_to :user

  has_many :invites #, :dependent => :destroy
  has_many :groups, :through => :event_groups
  has_many :event_groups

  validates :start_datetime, :presence => true
  validates :stop_datetime, :presence => true
  validates :name, :presence => true
  validates :short_description, :presence => true
  validate :start_date_before_end_date, :on => [ :create, :update ]

  domain_regex = URI::regexp(%w(http https))

  attr_accessor :invite_list, :group_tokens

  validates :map_url, :format => { :with => domain_regex }, :if => "map_url.present?"

  validates :event_url, :format => { :with => domain_regex }, :if => "event_url.present?"

  mount_uploader :image, EventPromoPhotoUploader

  after_create :create_invites
  after_update :create_invites

  attr_html_reader :description

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

  def datetime_range(opts = {})
    times = opts[:times] || false

    if start_datetime && stop_datetime
      same_year  = (start_datetime.year  == stop_datetime.year )
      same_month = (start_datetime.month == stop_datetime.month)
      same_day   = (start_datetime.day   == stop_datetime.day  )

      if same_year && same_month && same_day
        if times
          return start_datetime.strftime("%l:%M %p - ") + stop_datetime.strftime("%l:%M %p")
        else
          return start_datetime.strftime("%b %d %Y")
        end

      elsif same_year && same_month
        if times
          return start_datetime.strftime("%b %d %l:%M %p - ") + stop_datetime.strftime("%b %d, %Y %l:%M %p")
        else
          return start_datetime.strftime("%b %d - ") + stop_datetime.strftime("%d %Y")
        end

      elsif same_year
        if times
          return start_datetime.strftime("%b %d %l:%M %p - ") + stop_datetime.strftime("%b %d, %Y %l:%M %p")
        else
          return start_datetime.strftime("%b %d - ") + stop_datetime.strftime("%b %d %Y")
        end

      else
        if times
          return start_datetime.strftime("%b %d, %Y %l:%M %p - ") + stop_datetime.strftime("%b %d, %Y %l:%M %p")
        else
          return start_datetime.strftime("%b %d %Y - ") + stop_datetime.strftime("%b %d %Y")
        end
      end

    elsif start_datetime
      if times
        return start_datetime.strftime("%b %d, %Y %l:%M %p")
      else
        return start_datetime.strftime("%b %d %Y")
      end

    elsif stop_datetime
      if times
        return stop_datetime.strftime("%b %d, %Y %l:%M %p")
      else
        return stop_datetime.strftime("%b %d %Y")
      end
    end
  end

  private
  def create_invites
    if @invite_list
      @unique_invite_list = @invite_list.split(/,/).uniq.collect{|x| x.strip || x }
      delete_removed_email_in_invite_list @unique_invite_list
      @unique_invite_list.each do |email|
        invites = self.invites.create(:email => email.strip) unless self.invite_list.include? email
      end
      
      Rufus::Scheduler.singleton.in '10s' do
        Invite.email_recipients
      end
    end
  end

  def delete_removed_email_in_invite_list unique_invite_list
    self.invites.each do |invite|
      unless unique_invite_list.include? invite.email
        invite.destroy if invite.status.nil?
      end
    end
  end

  def start_date_before_end_date
    return if stop_datetime.blank? or start_datetime.blank?
    if stop_datetime <= start_datetime
      errors.add(:end_date, "cannot be before the start date")
    end
  end

end
