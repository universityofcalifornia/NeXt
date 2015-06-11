class AddRespondedToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :responded, :boolean, :default => false
    add_foreign_key(:invites, :events)
  end
end
