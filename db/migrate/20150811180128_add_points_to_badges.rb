class AddPointsToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :points, :integer, :default => 0
  end
end
