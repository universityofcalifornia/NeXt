class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|

      t.references :user
      t.references :organization

      t.string :title
      t.string :department
      t.text :description

      t.timestamps

      t.index :title
      t.index :department

    end
  end
end
