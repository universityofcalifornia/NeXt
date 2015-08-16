class RenameBadgeGroupsToBadgeCategories < ActiveRecord::Migration
  def change
    rename_table :badge_groups, :badge_categories
    rename_column :badges, :badge_group_id, :badge_category_id
  end
end
