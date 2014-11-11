class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.text :email, null: false

      t.string :name_first
      t.string :name_middle
      t.string :name_last, null: false
      t.string :name_suffix

      t.boolean :super_admin, :default => false

      t.timestamps

    end
  end
end
