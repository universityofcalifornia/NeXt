class CreateProjectIdeas < ActiveRecord::Migration
  def change
    create_table :project_ideas do |t|

      t.references :project
      t.references :idea

      t.timestamps

      t.index :created_at

    end
  end
end
