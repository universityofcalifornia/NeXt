class CreateBadgeRoles < ActiveRecord::Migration
  def change
    create_table :badge_roles do |t|
      t.references :badge
      t.references :user

      t.boolean :owner,  default: false
      t.boolean :editor, default: false
      t.boolean :giver,  default: false

      t.timestamps

      t.index :created_at
    end
  end
end
