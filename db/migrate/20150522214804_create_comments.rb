class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body
      t.references :idea, index: true
      t.references :user, :null => false, index: true
      t.references :parent, index: true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true
      t.integer :depth, :null => false, :default => 0
      t.timestamps
    end
  end
end
