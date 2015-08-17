class AddEngagementPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :idea_points,    :integer, :default => 0
    add_column :users, :project_points, :integer, :default => 0
    add_column :users, :other_points,   :integer, :default => 0
  end
end
