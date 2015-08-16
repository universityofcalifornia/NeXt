class CreateNewBadgeGroups < ActiveRecord::Migration
  def change
    create_table :badge_groups do |t|
      t.references :badge
      t.references :group

      t.timestamps
    end
  end
end
