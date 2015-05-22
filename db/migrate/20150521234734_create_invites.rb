class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :event_id
      t.string :email
      t.boolean :status, :default => false

      t.timestamps
    end
    add_index :invites, :event_id
    add_index :invites, [:event_id, :email]
  end
end
