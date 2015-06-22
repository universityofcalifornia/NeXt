class CondenseEventDateTimes < ActiveRecord::Migration
  def change
    change_column :events, :start_date, :datetime
    rename_column :events, :start_date, :start_datetime
    remove_column :events, :start_time
    change_column :events, :stop_date, :datetime
    rename_column :events, :stop_date, :stop_datetime
    remove_column :events, :stop_time
  end
end
