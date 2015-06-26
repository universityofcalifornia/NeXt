class AddUserIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :user_id, :integer
    Group.reset_column_information
    add_foreign_key(:groups, :users)
  end
end
