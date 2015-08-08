class AddMetadataToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :description, :text
    add_column :groups, :contact_email, :string
    add_column :groups, :listserv, :text
    add_column :groups, :meetings, :text
    add_column :groups, :membership_type, :string
  end
end
