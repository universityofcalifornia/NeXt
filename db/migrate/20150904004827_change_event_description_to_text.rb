class ChangeEventDescriptionToText < ActiveRecord::Migration
  def up
    change_column :events, :description, :text
  end

  def down
    change_column :events, :description, :string
  end
end
