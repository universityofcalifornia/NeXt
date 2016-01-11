class AddEditedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :edited, :boolean, default: false
    execute("update comments set edited = 0")
  end
end
