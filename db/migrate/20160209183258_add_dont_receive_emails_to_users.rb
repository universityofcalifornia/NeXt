class AddDontReceiveEmailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dont_receive_emails, :boolean
  end
end
