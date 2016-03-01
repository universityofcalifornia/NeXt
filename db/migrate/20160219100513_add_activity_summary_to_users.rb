class AddActivitySummaryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activity_summary, :boolean
  end
end
