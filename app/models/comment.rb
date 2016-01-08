class Comment < ActiveRecord::Base
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  acts_as_nested_set polymorphic: true #, :scope => [:commentable_id, :commentable_type]

  validates :body, :allow_nil => false, :presence => true

  attr_accessor :return_to

  def is_editable_by? user
    if user && (user.id == user_id || user.super_admin)
      return true
    else
      return false
    end
  end

  private

end
