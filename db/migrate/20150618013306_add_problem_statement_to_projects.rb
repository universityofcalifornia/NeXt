class AddProblemStatementToProjects < ActiveRecord::Migration
  def change
    # The limit is 16MiB - 1 to get a MySQL MEDIUMTEXT
    add_column :projects, :problem_statement, :text, :limit => 16.megabytes - 1
  end
end
