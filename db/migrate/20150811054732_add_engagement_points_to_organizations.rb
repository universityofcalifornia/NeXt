class AddEngagementPointsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :idea_points,    :integer, :default => 0
    add_column :organizations, :project_points, :integer, :default => 0
    add_column :organizations, :other_points,   :integer, :default => 0
  end
end
