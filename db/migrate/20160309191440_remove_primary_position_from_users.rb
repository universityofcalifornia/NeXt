class RemovePrimaryPositionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :primary_position_id, :integer
  end
end
