class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.string :image
      t.references :badge_group

      t.timestamps

      t.index :name
    end
  end
end
