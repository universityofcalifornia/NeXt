class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.references :user
      t.references :badge
      t.boolean :showcase, :default => false

      t.timestamps
    end
  end
end
