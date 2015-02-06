class CreateProjectStatuses < ActiveRecord::Migration
  def change
    create_table :project_statuses do |t|

      t.string :key
      t.string :name
      t.text :description
      t.text :icon

      t.timestamps

      t.index :key

    end
  end
end
