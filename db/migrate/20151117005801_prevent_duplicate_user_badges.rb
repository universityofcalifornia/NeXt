class PreventDuplicateUserBadges < ActiveRecord::Migration
  def up
    # Remove existing duplicates
    grouped = UserBadge.all.group_by { |user_badge| [user_badge.user_id, user_badge.badge_id] }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each(&:destroy)
    end

    add_index :user_badges, [:user_id, :badge_id], :unique => true
  end

  def down
    remove_index :user_badges, [:user_id, :badge_id]
  end
end
