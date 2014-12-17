class CreateIdeaStatuses < ActiveRecord::Migration
  def change
    create_table :idea_statuses do |t|

      t.string :key
      t.string :name
      t.text :description
      t.text :icon

      t.timestamps

      t.index :key

    end
  end
end
