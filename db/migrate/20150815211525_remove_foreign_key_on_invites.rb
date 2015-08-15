class RemoveForeignKeyOnInvites < ActiveRecord::Migration
  def change
    remove_foreign_key :invites, name: "invites_event_id_fk"
  end
end
