class AddIndexToCommentsRgt < ActiveRecord::Migration
  def change
    add_index :comments, :rgt
  end
end
