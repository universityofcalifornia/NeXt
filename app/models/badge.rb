class Badge < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :badge_group

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_many :badge_roles, dependent: :destroy
  has_many :users, through: :badge_roles, source: :user

  mount_uploader :image, BadgeUploader

  def self.is_creatable_by? user
    if user.nil?
      return false
    else
      return user.super_admin
    end
  end

  def is_editable_by? user
    if user.nil?
      return false
    elsif user.super_admin
      return true
    else
      return user.badge_roles.where(user_id: user.id, editor: true).count > 0
    end
  end

  def is_givable_by? user
    if user.nil?
      return false
    elsif user.super_admin
      return true
    else
      return user.badge_roles.where(user_id: user.id, giver: true).count > 0
    end
  end

end
