class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :invites, :responded, :email_sent
  end
end
