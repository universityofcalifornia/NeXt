class AlterStatusInvites < ActiveRecord::Migration
  def change
    change_column_default(:invites, :status, nil)
  end
end
