class CreateBadgeGroups < ActiveRecord::Migration
  def change
    create_table :badge_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
