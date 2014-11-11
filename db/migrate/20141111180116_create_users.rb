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

      t.index [:name_last, :name_first, :name_middle, :name_suffix], :name => 'name'
      t.index :super_admin
      t.index :created_at

    end
  end
end
